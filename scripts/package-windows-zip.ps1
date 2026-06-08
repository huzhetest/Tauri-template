# Package the Windows portable app into a zip archive.
param(
    [string]$OutputDir = "dist",
    [switch]$Overwrite
)

$ErrorActionPreference = "Stop"

$projectRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $projectRoot

function Get-WindowsReleaseDir {
    param([string]$Root)

    $exeName = "tauri-template.exe"
    $candidates = @(
        (Join-Path $Root "src-tauri\target\x86_64-pc-windows-msvc\release"),
        (Join-Path $Root "src-tauri\target\release")
    )

    foreach ($dir in $candidates) {
        if (Test-Path (Join-Path $dir $exeName)) {
            return $dir
        }
    }

    return $null
}

$version = (Get-Content package.json -Raw | ConvertFrom-Json).version
$releaseDir = Get-WindowsReleaseDir -Root $projectRoot
$exeName = "tauri-template.exe"

if (-not $releaseDir) {
    Write-Error "Executable not found. Run npm run tauri:build:windows first."
}

$exePath = Join-Path $releaseDir $exeName
Write-Host "==> Using release directory: $releaseDir"

$stagingRoot = Join-Path (Join-Path $projectRoot $OutputDir) "portable"
$stagingDir = Join-Path $stagingRoot "tauri-template"

if (Test-Path $stagingDir) {
    Remove-Item $stagingDir -Recurse -Force
}
New-Item -ItemType Directory -Force -Path $stagingDir | Out-Null

Copy-Item $exePath $stagingDir

Get-ChildItem -Path $releaseDir -Filter "*.dll" -File | ForEach-Object {
    Copy-Item $_.FullName $stagingDir
}

$zipName = "tauri-template-v$version-windows-x64.zip"
$zipPath = Join-Path (Join-Path $projectRoot $OutputDir) $zipName

if ((Test-Path $zipPath) -and -not $Overwrite) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $zipName = "tauri-template-v$version-windows-x64-$timestamp.zip"
    $zipPath = Join-Path (Join-Path $projectRoot $OutputDir) $zipName
} elseif ((Test-Path $zipPath) -and $Overwrite) {
    Remove-Item $zipPath -Force
}

New-Item -ItemType Directory -Force -Path (Split-Path $zipPath) | Out-Null
Compress-Archive -Path $stagingDir -DestinationPath $zipPath -CompressionLevel Optimal

Write-Host "==> Portable zip created: $zipPath"
