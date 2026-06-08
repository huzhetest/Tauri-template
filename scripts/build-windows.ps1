# Build Tauri-template Windows portable app and package it as a zip.
# Prerequisites: Node.js, Rust stable, Visual Studio C++ build tools, and WebView2 runtime.

$ErrorActionPreference = "Stop"

$projectRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $projectRoot

Write-Host "==> Building Windows app..."
npm run tauri:build:windows

Write-Host "==> Packaging portable zip..."
& (Join-Path $PSScriptRoot "package-windows-zip.ps1")
