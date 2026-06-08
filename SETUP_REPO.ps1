# ═══════════════════════════════════════════════════════════════
# SETUP_REPO.ps1
# Crea el repositorio "miguel-tillero-portfolio" en Descargas,
# copia todos los archivos y hace el push a GitHub.
# ═══════════════════════════════════════════════════════════════

$ErrorActionPreference = "Stop"
$descargas = "C:\Users\ALIANZA FRANCESA\Downloads"
$carpeta   = "$descargas\miguel-tillero-portfolio"
$repoURL   = "https://github.com/migueltillero-ship-it/afsc-direccion.git"

Write-Host "`n╔══════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  SETUP — Miguel Tillero Portfolio    ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════╝`n" -ForegroundColor Cyan

# ── PASO 1: Crear carpeta ────────────────────────────────────
Write-Host "[1/5] Creando carpeta del repositorio..." -ForegroundColor Yellow
if (-Not (Test-Path $carpeta)) {
    New-Item -ItemType Directory -Path $carpeta | Out-Null
    Write-Host "      ✅ Carpeta creada: $carpeta" -ForegroundColor Green
} else {
    Write-Host "      ℹ️  Carpeta ya existe: $carpeta" -ForegroundColor DarkYellow
}

# ── PASO 2: Copiar el index.html ─────────────────────────────
Write-Host "[2/5] Copiando index.html..." -ForegroundColor Yellow
$indexHtml = "$descargas\index.html"
if (Test-Path $indexHtml) {
    Copy-Item $indexHtml "$carpeta\index.html" -Force
    Write-Host "      ✅ index.html copiado" -ForegroundColor Green
} else {
    Write-Host "      ❌ No se encontró index.html en Descargas. Colócalo ahí primero." -ForegroundColor Red
    exit 1
}

# ── PASO 3: Copiar los archivos multimedia ───────────────────
Write-Host "[3/5] Copiando archivos multimedia..." -ForegroundColor Yellow

$archivos = @(
    "Miguel_Tillero_video_bienvenida.mp4",
    "Arrival_at_the_Terminal_(1).mp3",
    "miguel-tillero-paris-tour-eiffel.png",
    "miguel-tillero-paris-alliance-francaise.png",
    "miguel-tillero-director-general-afsc.png",
    "miguel-tillero-gestion-cultural.png",
    "miguel-tillero-retrato-oficial.png",
    "miguel-tillero-pedagogo-internacional.png",
    "alianza-francesa-san-cristobal-fachada.jpg",
    "marble-texture-emerald-gold.jpg"
)

foreach ($archivo in $archivos) {
    $origen = "$descargas\$archivo"
    if (Test-Path $origen) {
        Copy-Item $origen "$carpeta\$archivo" -Force
        Write-Host "      ✅ $archivo" -ForegroundColor Green
    } else {
        Write-Host "      ⚠️  No encontrado (opcional): $archivo" -ForegroundColor DarkYellow
    }
}

# ── PASO 4: Inicializar git y conectar al repo ───────────────
Write-Host "`n[4/5] Inicializando repositorio git..." -ForegroundColor Yellow
Set-Location $carpeta

if (-Not (Test-Path ".git")) {
    git init
    git remote add origin $repoURL
    Write-Host "      ✅ Repositorio inicializado" -ForegroundColor Green
} else {
    # Si ya hay un .git, solo asegurar el remote
    $remotes = git remote
    if ($remotes -notcontains "origin") {
        git remote add origin $repoURL
    }
    Write-Host "      ✅ Repositorio ya inicializado" -ForegroundColor Green
}

# Configurar rama principal
git branch -M main

# ── PASO 5: Commit y push ────────────────────────────────────
Write-Host "[5/5] Haciendo commit y push a GitHub..." -ForegroundColor Yellow
git add .
git status
git commit -m "feat: portfolio completo — video bienvenida + audio + fotos Paris + paleta esmeralda & oro"

Write-Host "`n  Haciendo push..." -ForegroundColor Cyan
git push -u origin main --force

Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  ✅ ¡LISTO! Sitio publicado en GitHub Pages          ║" -ForegroundColor Green
Write-Host "║                                                      ║" -ForegroundColor Green
Write-Host "║  URL: https://migueltillero-ship-it.github.io/       ║" -ForegroundColor Green
Write-Host "║       afsc-direccion/                                ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Green

