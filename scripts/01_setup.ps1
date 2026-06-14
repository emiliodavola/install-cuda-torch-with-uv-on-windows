Write-Host "🚀 Starting PyTorch CUDA Setup with uv..." -ForegroundColor Cyan

if (!(Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "📦 uv not found. Installing uv..." -ForegroundColor Yellow
    powershell -ExecutionPolicy ByPass -Command "irm https://astral.sh/uv/install.ps1 | iex"
}

Write-Host "🛠️ Creating virtual environment and syncing dependencies..." -ForegroundColor Cyan
uv venv --python 3.12
uv sync

Write-Host "✅ Setup complete! Use .\scripts\verify.ps1 to validate." -ForegroundColor Green
