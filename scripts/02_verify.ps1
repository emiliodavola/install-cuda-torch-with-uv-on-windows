Write-Host "🔍 Verifying PyTorch CUDA installation..." -ForegroundColor Cyan

uv run python -c "
import torch
print(f'Torch version: {torch.__version__}')
print(f'CUDA available: {torch.cuda.is_available()}')
if torch.cuda.is_available():
    print(f'CUDA Version: {torch.version.cuda}')
    print(f'GPU Device: {torch.cuda.get_device_name(0)}')
else:
    print('❌ CUDA NOT DETECTED')
"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Verification script executed." -ForegroundColor Green
} else {
    Write-Host "❌ Verification script failed." -ForegroundColor Red
}
