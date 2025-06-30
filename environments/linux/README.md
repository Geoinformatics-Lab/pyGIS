# PyGILE Linux Installation Guide

## 1. Download PyGILE Repository

Go to https://github.com/Geoinformatics-Lab/PyGILE

Click green Code button and Download ZIP

Extract to home directory to get PyGILE-main folder

## 2. Download and Install Miniforge3

Open Terminal:

```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
```

```bash
chmod +x Miniforge3-Linux-x86_64.sh
```

```bash
./Miniforge3-Linux-x86_64.sh
```

During installation:
- Press Enter to continue
- Press Enter after reading license
- Type yes and press Enter
- Press Enter for default location
- **WARNING: TYPE NO WHEN ASKED ABOUT SHELL PROFILE**

## 3. Initialize Miniforge3

```bash
eval "$(/home/$USER/miniforge3/bin/conda shell.bash hook)"
```

```bash
conda init
```

```bash
source ~/.bashrc
```

Test installation:

```bash
mamba --version
```

## 4. Create PyGILE Environment

Navigate to setup folder:

```bash
cd PyGILE-main/environments/linux
```

Choose one method:

Method A - Using script:
```bash
chmod +x install_pygile_linux.sh
./install_pygile_linux.sh
```

Method B - Using YAML:
```bash
mamba env create -f environment.yaml
```

## 5. Activate Environment

```bash
conda deactivate
```

```bash
eval "$(mamba shell hook --shell bash)"
```

```bash
mamba activate pygile_base
```

Install kernel for Jupyter:

```bash
conda install ipykernel
```

```bash
python -m ipykernel install --user --name pygile_base --display-name "Python (pygile_base)"
```

## 6. Start Jupyter Lab

```bash
jupyter lab
```

## 7. Test Installation

```bash
python -c 'import geopandas, rasterio, geowombat, jupyter; print("All packages working!")'
```

Should show: All packages working!

## Quick Start After Setup

```bash
mamba activate pygile_base
```

```bash
cd PyGILE-main
```

```bash
jupyter lab
```

Open any notebook in pyGILE notebooks folder and start learning