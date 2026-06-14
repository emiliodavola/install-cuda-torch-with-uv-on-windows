# 🚀 Instalación de PyTorch con CUDA en Windows usando `uv`

##📌 Requisitos previos

Antes de instalar PyTorch con GPU, asegúrate de tener:

### 1. GPU NVIDIA compatible

- RTX 20xx / 30xx / 40xx (ej. RTX 3090)

### 2. Driver NVIDIA actualizado

Verifica con:

```powershell
nvidia-smi
```

Si no funciona o está desactualizado, instala el driver desde NVIDIA.

### 3. Python

- Recomendado: Python 3.12.x
- Evitar mezclar múltiples versiones

Verificar:

```powershell
python --version
```

### 4. `uv` instalado

Instalar `uv`:

```powershell
pip install uv
```

Verificar:

```powershell
uv --version
```

## 📦 Crear proyecto con `uv`

```powershell
mkdir my-project
cd my-project
uv init
```

## 🧠 Configurar entorno virtual

```powershell
uv venv
uv sync
```

## ⚡ Instalación de PyTorch con CUDA (RTX GPU)

### 🔥 Opción recomendada (CUDA 12.1)

```powershell
uv add torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

### ⚙️ Si usas pyproject.toml (recomendado)

1. Añadir índice CUDA

```toml
[[tool.uv.index]]
name = "pytorch"
url = "https://download.pytorch.org/whl/cu121"
explicit = true
```

2. Forzar uso del índice para torch

```toml
[tool.uv.sources]
torch = { index = "pytorch" }
torchvision = { index = "pytorch" }
torchaudio = { index = "pytorch" }
```

3. Dependencias ejemplo

```toml
[project]
requires-python = ">=3.12,<3.13"

dependencies = [
    "torch",
    "torchvision",
    "torchaudio",
]
```

## 🔄 Reinstalación limpia (si algo falla)

```powershell
Remove-Item -Recurse -Force .venv
Remove-Item uv.lock
uv sync
```

## 🧪 Verificación de GPU

Ejecutar:

```powershell
uv run python -c "import torch; print(torch.__version__); print(torch.version.cuda); print(torch.cuda.is_available()); print(torch.cuda.get_device_name(0))"
```

Resultado esperado:

```powershell
2.x.x+cu121
12.1
True
NVIDIA GeForce RTX 3090
```

⚠️ Problemas comunes
❌ Sale +cpu

Significa que instalaste PyPI en vez del índice CUDA.

👉 Solución:

- borrar .venv
- revisar tool.uv.sources
- ejecutar uv sync

❌ CUDA no disponible

Posibles causas:

- Driver NVIDIA desactualizado
- Instalación CPU-only
- Entorno no recreado tras cambio de índice

❌ Conflictos con dependencias (ej. tabpfn)

Si otro paquete fuerza versiones:

```powershell
uv tree
```

y ajusta versiones incompatibles.

🧠 Resumen
`uv` funciona perfecto para PyTorch + CUDA
La clave es usar índice oficial de PyTorch
Siempre recrear el entorno cuando cambias CUDA/PyTorch
Windows funciona sin instalar CUDA Toolkit manualmente (solo driver)