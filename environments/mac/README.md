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
- **🚨⚠️🛑 CRITICAL: Type NO when asked about shell profile 🛑⚠️🚨**

## 4. Initialize Miniforge3 Manually

```bash
eval "$(/Users/$USER/miniforge3/bin/conda shell.bash hook)"
conda init
```

For zsh users (default on newer macOS):
```bash
conda init zsh
exec zsh -l
```

For bash users:
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

Run the installation script:
```bash
chmod +x install_pygile_macos.sh
./install_pygile_macos.sh
```

## 6. Activate Environment

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
jupyter lab
```

Navigate to pyGILE-main folder and open notebooks in pyGILE_notebooks folder