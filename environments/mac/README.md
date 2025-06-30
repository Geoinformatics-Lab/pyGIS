# PyGILE macOS Installation Guide

## 1. Download PyGILE Repository

Go to https://github.com/Geoinformatics-Lab/pyGILE

Click green Code button and Download ZIP

Extract to home directory to get pyGILE-main folder

## 2. Download Miniforge3

Go to https://github.com/conda-forge/miniforge/releases/latest/

**For Intel Macs:** Download `Miniforge3-MacOSX-x86_64.sh`

**For Apple Silicon Macs (M1/M2/M3):** Download `Miniforge3-MacOSX-arm64.sh`

To check your Mac: Apple menu → About This Mac

## 3. Install Miniforge3

Open Terminal (Cmd+Space, type Terminal)

Navigate to Downloads:

```bash
cd ~/Downloads
```

**For Intel Macs:**
```bash
chmod +x Miniforge3-MacOSX-x86_64.sh
./Miniforge3-MacOSX-x86_64.sh
```

**For Apple Silicon Macs:**
```bash
chmod +x Miniforge3-MacOSX-arm64.sh
./Miniforge3-MacOSX-arm64.sh
```

During installation:
- Press Enter to continue
- Press Enter after reading license
- Type yes and press Enter
- Press Enter for default location
- **WARNING: TYPE NO WHEN ASKED ABOUT SHELL PROFILE**

## 4. Initialize Miniforge3

```bash
eval "$(/Users/$USER/miniforge3/bin/conda shell.bash hook)"
```

```bash
conda init
```

For zsh (default on newer macOS):
```bash
conda init zsh
exec zsh -l
```

For bash:
```bash
conda init bash
```

Test installation:

```bash
mamba --version
```

## 5. Create PyGILE Environment

Navigate to setup folder:

```bash
cd pyGILE-main/environments/mac
```

Choose one method:

Method A - Using script:
```bash
chmod +x install_pygile_macos.sh
./install_pygile_macos.sh
```

Method B - Using YAML:
```bash
mamba env create -f environment.yaml
```

## 6. Activate Environment

```bash
conda deactivate
```

```bash
eval "$(mamba shell hook --shell bash)"
```

For zsh users:
```bash
eval "$(mamba shell hook --shell zsh)"
```

```bash
mamba activate pygile_base
```

## 7. Test Installation

```bash
python -c 'import geopandas, rasterio, geowombat, jupyter; print("All packages working!")'
```

Should show: All packages working!

## Daily Usage

```bash
mamba activate pygile_base
```

```bash
jupyter lab
```

Navigate to pyGILE-main folder and open notebooks in pyGILE_notebooks folder

## macOS Notes

For Apple Silicon Macs: Use ARM64 version

If needed, install Xcode Command Line Tools:
```bash
xcode-select --install
```