<#
.SYNOPSIS
    Render incremental e seguro do site, sem destruir docs/.

.DESCRIPTION
    O `quarto render` completo limpa o output-dir (docs/) antes de comecar.
    Se ele falhar no meio - por exemplo porque um sincronizador ou antivirus
    travou um arquivo por um instante - o resultado e um docs/ mutilado, com
    centenas de HTML apagados que so voltam depois de horas de re-render.

    Este script evita isso:
      * sempre passa --no-clean, entao nada e apagado preventivamente;
      * renderiza so os posts cujo .qmd esta mais novo que o .html;
      * tenta de novo quando o erro e de arquivo travado (os error 32 / 1224);
      * limpa os temporarios que o Quarto deixa para tras quando aborta.

    O index.qmd e re-renderizado junto automaticamente pelo Quarto, entao a
    listagem da home, o listings.json e o sitemap.xml ficam atualizados.

.PARAMETER Posts
    Nomes ou caminhos dos posts a renderizar. Aceita "Ergen-Kohl2019",
    "posts/Ergen-Kohl2019.qmd" ou o caminho completo. Se omitido, o script
    detecta sozinho o que esta desatualizado.

.PARAMETER All
    Renderiza o projeto inteiro (ainda com --no-clean).

.PARAMETER WhatIf
    So mostra o que seria renderizado.

.EXAMPLE
    .\code\render-posts.ps1
    Renderiza tudo que esta desatualizado.

.EXAMPLE
    .\code\render-posts.ps1 -Posts Ergen-Kohl2019, DeKadt-GrzymalaBusse2025

.EXAMPLE
    .\code\render-posts.ps1 -WhatIf
#>

[CmdletBinding()]
param(
    [string[]] $Posts,
    [switch]   $All,
    [switch]   $WhatIf,
    [int]      $MaxRetries = 4
)

$ErrorActionPreference = 'Stop'

# Raiz do projeto = pasta acima de code/
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root

if (-not (Test-Path (Join-Path $Root '_quarto.yml'))) {
    throw "Nao achei _quarto.yml em $Root - o script precisa rodar dentro do repo."
}

function Write-Step { param([string]$Msg) Write-Host "==> $Msg" -ForegroundColor Cyan }
function Write-Ok   { param([string]$Msg) Write-Host "    $Msg" -ForegroundColor Green }
function Write-Warn { param([string]$Msg) Write-Host "    $Msg" -ForegroundColor Yellow }

# ---------------------------------------------------------------------------
# 1. Descobrir o que renderizar
# ---------------------------------------------------------------------------

function Resolve-PostPath {
    param([string]$Name)
    $candidates = @(
        $Name,
        (Join-Path $Root $Name),
        (Join-Path $Root "posts/$Name"),
        (Join-Path $Root "posts/$Name.qmd"),
        (Join-Path $Root "posts/notes/$Name.qmd")
    )
    foreach ($c in $candidates) {
        if ((Test-Path $c -PathType Leaf) -and ($c -like '*.qmd')) {
            return (Resolve-Path $c).Path
        }
    }
    throw "Post nao encontrado: '$Name'"
}

function Get-StalePosts {
    # .qmd sem .html correspondente, ou com .qmd mais novo que o .html
    $stale = @()
    Get-ChildItem -Path (Join-Path $Root 'posts') -Filter *.qmd -Recurse -File | ForEach-Object {
        $rel  = $_.FullName.Substring($Root.Length).TrimStart('\', '/')
        $html = Join-Path $Root ($rel -replace '\.qmd$', '.html' -replace '^posts', 'docs\posts')
        if (-not (Test-Path $html)) {
            $stale += [pscustomobject]@{ Path = $_.FullName; Reason = 'sem HTML' }
        } elseif ($_.LastWriteTime -gt (Get-Item $html).LastWriteTime) {
            $stale += [pscustomobject]@{ Path = $_.FullName; Reason = 'QMD mais novo' }
        }
    }
    return $stale
}

$targets = @()

if ($All) {
    Write-Step "Modo -All: projeto inteiro (com --no-clean)"
} elseif ($Posts) {
    $targets = $Posts | ForEach-Object { Resolve-PostPath $_ }
    Write-Step "$($targets.Count) post(s) indicado(s) manualmente"
} else {
    Write-Step "Procurando posts desatualizados..."
    $stale = Get-StalePosts
    if ($stale.Count -eq 0) {
        Write-Ok "Nada desatualizado. docs/ ja esta em dia."
        return
    }
    $stale | ForEach-Object {
        Write-Host ("    - {0}  ({1})" -f (Split-Path $_.Path -Leaf), $_.Reason)
    }
    $targets = $stale.Path
}

if ($WhatIf) {
    Write-Warn "-WhatIf: nada foi renderizado."
    return
}

# ---------------------------------------------------------------------------
# 2. Renderizar com retry
# ---------------------------------------------------------------------------

# Erros de arquivo temporariamente travado por sync/antivirus/indexador.
# 32   = ERROR_SHARING_VIOLATION
# 1224 = ERROR_USER_MAPPED_FILE
$lockPattern = 'os error (32|1224)|being used by another process|user-mapped section'

function Invoke-QuartoRender {
    param([string[]]$Args, [string]$Label)

    for ($attempt = 1; $attempt -le $MaxRetries; $attempt++) {
        Write-Step "Renderizando $Label (tentativa $attempt/$MaxRetries)"

        $output = & quarto render @Args --no-clean 2>&1 | Out-String
        $ok = $LASTEXITCODE -eq 0

        Write-Host $output.TrimEnd()

        if ($ok) { Write-Ok "OK: $Label"; return $true }

        if ($output -match $lockPattern) {
            $wait = [Math]::Min(30, [Math]::Pow(2, $attempt))
            Write-Warn "Arquivo travado por outro processo. Nova tentativa em ${wait}s..."
            Start-Sleep -Seconds $wait
            continue
        }

        # Erro real de conteudo: nao adianta repetir
        Write-Warn "Falha nao relacionada a lock. Interrompendo."
        return $false
    }

    Write-Warn "Esgotadas as $MaxRetries tentativas para $Label."
    return $false
}

$failed = @()

if ($All) {
    if (-not (Invoke-QuartoRender -Args @() -Label 'projeto inteiro')) { $failed += 'projeto' }
} else {
    foreach ($t in $targets) {
        $rel = $t.Substring($Root.Length).TrimStart('\', '/')
        if (-not (Invoke-QuartoRender -Args @($rel) -Label $rel)) { $failed += $rel }
    }
}

# ---------------------------------------------------------------------------
# 3. Faxina pos-render
# ---------------------------------------------------------------------------

Write-Step "Limpando artefatos residuais"

# Temporarios que o Quarto deixa quando o post-render aborta
$junk = @(
    (Join-Path $Root 'docs/index.feed-full-staged'),
    (Join-Path $Root 'docs/index-listing.json')
)
$junk += Get-ChildItem -Path (Join-Path $Root 'docs') -Filter '*-listing.json' -Recurse -File -ErrorAction SilentlyContinue |
         Select-Object -ExpandProperty FullName
$junk += Get-ChildItem -Path (Join-Path $Root 'docs') -Filter '*.feed-full-staged' -Recurse -File -ErrorAction SilentlyContinue |
         Select-Object -ExpandProperty FullName

$removed = 0
$junk | Sort-Object -Unique | Where-Object { $_ -and (Test-Path $_) } | ForEach-Object {
    Remove-Item $_ -Force -ErrorAction SilentlyContinue
    $removed++
}

# HTML gerados por engano DENTRO de posts/ (render fora do modo projeto)
Get-ChildItem -Path (Join-Path $Root 'posts') -Filter *.html -Recurse -File -ErrorAction SilentlyContinue |
    ForEach-Object { Remove-Item $_.FullName -Force; $removed++ }

# Sobras de render de documento avulso na raiz
@('site_libs', 'index_files') | ForEach-Object {
    $p = Join-Path $Root $_
    if (Test-Path $p) { Remove-Item $p -Recurse -Force; $removed++ }
}

Write-Ok "$removed artefato(s) residual(is) removido(s)"

# ---------------------------------------------------------------------------
# 4. Sanidade: docs/ nao pode ter encolhido
# ---------------------------------------------------------------------------

Write-Step "Conferindo integridade de docs/"

$deleted = @(& git status --porcelain -- docs | Where-Object { $_ -match '^\s*D\s' })
if ($deleted.Count -gt 0) {
    Write-Host ""
    Write-Warn "ATENCAO: $($deleted.Count) arquivo(s) de docs/ aparecem como DELETADOS."
    Write-Warn "Isso nao deveria acontecer com --no-clean. Para desfazer:"
    Write-Warn "    git restore docs/"
    $deleted | Select-Object -First 10 | ForEach-Object { Write-Host "      $_" }
} else {
    Write-Ok "Nenhum arquivo de docs/ foi perdido."
}

$htmlCount = (Get-ChildItem (Join-Path $Root 'docs/posts') -Filter *.html -File).Count
$qmdCount  = (Get-ChildItem (Join-Path $Root 'posts') -Filter *.qmd -File).Count
Write-Ok "docs/posts: $htmlCount HTML  |  posts: $qmdCount QMD"

if ($failed.Count -gt 0) {
    Write-Host ""
    Write-Warn "Falharam: $($failed -join ', ')"
    exit 1
}

Write-Host ""
Write-Ok "Concluido."
