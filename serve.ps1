# serve.ps1 — run the site locally with live reload
# Usage:  .\serve.ps1        then open http://localhost:4001
#
# Finds the installed Ruby automatically, prepends it to PATH for this
# session only, then starts Jekyll with --livereload so edits show instantly.

$ErrorActionPreference = 'Stop'

# Locate Ruby (RubyInstaller default layout: C:\RubyXX-x64\bin\ruby.exe)
$rubyBin = Get-ChildItem 'C:\' -Directory -Filter 'Ruby*' -ErrorAction SilentlyContinue |
    ForEach-Object { Join-Path $_.FullName 'bin' } |
    Where-Object { Test-Path (Join-Path $_ 'ruby.exe') } |
    Select-Object -First 1

if (-not $rubyBin) {
    Write-Error "Ruby not found under C:\Ruby*. Install it with:  winget install RubyInstallerTeam.RubyWithDevKit.3.3"
    exit 1
}

$env:Path = "$rubyBin;$env:Path"
Write-Host "Using Ruby at $rubyBin" -ForegroundColor Cyan

# Ensure gems are installed
if (-not (Test-Path 'Gemfile.lock')) {
    Write-Host "Installing gems (first run)..." -ForegroundColor Yellow
    bundle install
}

Write-Host "Starting Jekyll at http://localhost:4001  (Ctrl+C to stop)" -ForegroundColor Green
bundle exec jekyll serve --livereload --port 4001 --open-url
