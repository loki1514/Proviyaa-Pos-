# Proviyaa POS Windows Launcher
$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = (Resolve-Path "$ScriptDir\..").Path
$EnvFile = if ($env:PROVIYAA_ENV_FILE) { $env:PROVIYAA_ENV_FILE } else { Join-Path $ProjectRoot ".env.local" }

if (-not (Test-Path $EnvFile)) {
    Write-Error "Missing $EnvFile`nCopy .env.local.example to .env.local and fill local-safe values."
    exit 1
}

$AllowedKeys = @('APP_ENV', 'DATA_MODE', 'SUPABASE_URL', 'SUPABASE_PUBLISHABLE_KEY', 'PROVIYAA_API_BASE_URL', 'SYNC_ENABLED')
$DartDefines = @()

Get-Content $EnvFile | ForEach-Object {
    $line = $_.Trim()
    if (-not $line -or $line.StartsWith('#')) { return }
    if (-not ($line -match '^([^=]+)=(.*)$')) {
        Write-Error "Invalid env line (expected KEY=VALUE): $line"
        exit 1
    }
    $key = $Matches[1].Trim()
    $value = $Matches[2].Trim()
    if ($AllowedKeys -contains $key) {
        $DartDefines += "--dart-define=$key=$value"
    } else {
        Write-Error "Refusing unsupported or secret env key: $key"
        exit 1
    }
}

Push-Location $ProjectRoot
try {
    $targetArgs = $args
    if ($targetArgs.Length -eq 0) {
        $targetArgs = @('-d', 'chrome')
    }
    $allArgs = @('run') + $DartDefines + $targetArgs
    Write-Host "Running: flutter $($allArgs -join ' ')" -ForegroundColor Cyan
    & flutter @allArgs
} finally {
    Pop-Location
}
