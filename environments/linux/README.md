# PyGILE Linux Installation Guide

Complete Python environment for geospatial analysis

## 1. Download and Extract Repository

Go to: https://github.com/Geoinformatics-Lab/pyGILE

Click green "Code" button -> "Download ZIP"

Extract the ZIP file to your home directory

You will get a folder named "pyGILE-main"

## 2. Download Miniforge3

Open Terminal (Ctrl+Alt+T) and run:

```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
```

## 3. Install Miniforge3

```bash
chmod +x Miniforge3-Linux-x86_64.sh
./Miniforge3-Linux-x86_64.sh
```

During installation:
- Press Enter to continue reading license
- Press Enter again after reading license  
- Type "yes" and press Enter to accept license
- Press Enter to accept default installation location
- **🚨⚠️🛑 CRITICAL: Type NO when asked about shell profile 🛑⚠️🚨**

Installation will complete with "Thank you for installing Miniforge3!" message.

## 4. Initialize Miniforge3 Manually

Since you chose "no" during installation, run these commands:

```bash
eval "$(/home/$USER/miniforge3/bin/conda shell.bash hook)"
conda init
source ~/.bashrc
```

Test if mamba is working:
```bash
mamba --version
```

You should see a version number like "mamba 2.1.1"

## 5. Create PyGILE Environment

Navigate to the Linux setup folder:

```bash
cd pyGILE-main/environments/linux
```

Run the installation script:
```bash
chmod +x install_pygile_linux.sh
./install_pygile_linux.sh
```

## 6. Activate Environment

First, initialize the current bash shell:
```bash
eval "$(mamba shell hook --shell bash)"
```

Then activate:
```bash
mamba activate pygile_base
```

Your prompt should now show (pygile_base) at the beginning of each line.

## 7. Test Installation

```bash
python -c 'import geopandas, rasterio, geowombat, jupyter; print("All packages working!")'
```

You should see: "All packages working!"

**SUCCESS!**

## Daily Usage

Every time you want to use PyGILE:

1. Open Terminal (Ctrl+Alt+T)
2. `mamba activate pygile_base`
3. `jupyter lab`

Navigate to pyGILE-main folder and open notebooks in pyGILE_notebooks folder