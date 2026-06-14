# Troubleshooting Guide

This guide helps you resolve common issues when installing PyTorch with CUDA using `uv` on Windows.

## ❌ Problem: PyTorch is installed as CPU-only (`+cpu`)

**Symptom**: `torch.cuda.is_available()` returns `False`, and the version string ends in `+cpu`.

**Cause**: This usually happens when `uv` resolves dependencies from PyPI instead of the official PyTorch CUDA index, often due to a conflict or an initial installation without the correct index.

**Solution**:

1. **Clean the environment**: Delete the `.venv` directory and the `uv.lock` file.

```powershell
.\scripts\03_clean.ps1
```

2. **Verify Configuration**: Ensure your `pyproject.toml` contains the explicit CUDA index:

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

3. **Sync again**: Run `uv sync` or `.\scripts\01_setup.ps1`.

---

## ❌ Problem: CUDA not detected (Even with GPU installed)

**Symptom**: PyTorch is installed, but `torch.cuda.is_available()` is `False`.

**Possible Causes**:

- **Outdated Drivers**: Your NVIDIA drivers are too old for the installed CUDA version.
  - *Check*: Run `nvidia-smi` in your terminal. If it fails or shows a very old CUDA version, update your drivers from the official NVIDIA website.
- **Incorrect Installation**: You might have accidentally installed the CPU version (see "CPU-only" section above).
- **Driver/Runtime Mismatch**: In rare cases, the environment needs to be recreated after a driver update.

---

## ❌ Problem: Dependency Conflicts (e.g., with `tabpfn` or other libs)

**Symptom**: `uv sync` fails with version conflicts or forces PyTorch to downgrade to a CPU version.

**Cause**: Some packages have strict dependencies on specific versions of `torch` that may not match the CUDA index versions.

**Solution**:

1. **Analyze the dependency tree**: Use `uv tree` to identify which package is forcing the conflict.

```powershell
uv tree
```

2. **Force sources**: Ensure you are using the `[tool.uv.sources]` section in `pyproject.toml` as shown above; this tells `uv` to prioritize the PyTorch index for these specific packages regardless of what other dependencies suggest.
3. **Adjust versions**: If a conflict persists, try adjusting the version constraints of the conflicting package in your `dependencies` list.


