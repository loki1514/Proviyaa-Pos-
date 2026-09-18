# Git Commit & Push Helper for Proviyaa POS
$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = (Resolve-Path "$ScriptDir/..").Path

Push-Location $ProjectRoot
try {
    Write-Host "Formatting Dart files..." -ForegroundColor Cyan
    & dart format .

    Write-Host "Staging all changes..." -ForegroundColor Cyan
    & git add .

    $commitMsg = if ($args.Length -gt 0) { $args -join ' ' } else { "Fix analyzer warnings: curly braces in flow control and replace deprecated value with initialValue" }
    Write-Host "Committing: '$commitMsg'..." -ForegroundColor Cyan
    & git commit -m "$commitMsg"

    Write-Host "Pushing to remote origin main..." -ForegroundColor Cyan
    & git push origin main

    Write-Host "Successfully pushed to Git!" -ForegroundColor Green
} finally {
    Pop-Location
}
