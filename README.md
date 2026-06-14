# PyTorch + CUDA Setup for Windows with uv

This repository provides a fully reproducible setup for installing and validating PyTorch with NVIDIA GPU support on Windows using the `uv` package manager.

## 📋 Requirements

- **OS**: Windows 10/11
- **GPU**: NVIDIA GPU (e.g., RTX 20xx, 30xx, 40xx)
- **Driver**: Updated NVIDIA drivers (`nvidia-smi` should work in your terminal)
- **Python**: 3.12 (Recommended)
- **Package Manager**: `uv`

## 🚀 Installation

### Option 1: Automated Setup (Recommended)

The easiest way to get started is using the provided scripts:

1. Clone the repository:

```bash
git clone <repo_url>
cd install-cuda-torch-with-uv-on-windows
```

2. Run the setup script:

```powershell
.\scripts\01_setup.ps1
```

### Option 2: Manual Setup

If you prefer to set it up manually in your own project:

1. Initialize a new `uv` project:

```powershell
uv init my-project
cd my-project
```

2. Add PyTorch with the CUDA 12.1 index:

```powershell
uv add torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

**OR** configure your `pyproject.toml` as follows to ensure reproducibility:

```toml
[[tool.uv.index]]
name = "pytorch"
url = "https://download.pytorch.org/whl/cu121"
explicit = true

[tool.uv.sources]
torch = { index = "pytorch" }
torchvision = { index = "pytorch" }
torchaudio = { index = "pytorch" }
```

Then run `uv sync`.

## ✅ Verification

To verify that PyTorch is correctly installed with CUDA support, run:

```powershell
.\scripts\02_verify.ps1
```

### Expected Result

The output should show:

- **Torch version**: e.g., `2.5.1+cu121`
- **CUDA available**: `True`
- **GPU Device**: The name of your NVIDIA GPU (e.g., `NVIDIA GeForce RTX 3090`)

## 🧹 Maintenance

To perform a clean reinstallation (useful if you encounter issues with CPU-only versions):

```powershell
.\scripts\03_clean.ps1
.\scripts\01_setup.ps1
```

## 🛠️ Troubleshooting

For common issues, please refer to the [Troubleshooting Guide](docs/troubleshooting.md).


