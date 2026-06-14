Write-Host "🧹 Cleaning environment..." -ForegroundColor Yellow
Remove-Item -Recurse -Force .venv -ErrorAction SilentlyContinue
Remove-Item uv.lock -ErrorAction SilentlyContinue
Write-Host "✨ Environment cleaned." -ForegroundColor Green
