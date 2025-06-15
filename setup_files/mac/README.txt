# PyGIS Setup for macOS


## Step 1: Download and Extract Repository

Go to: https://github.com/Geoinformatics-Lab/pyGIS
Click green "Code" button -> "Download ZIP"
Extract the ZIP file to your home directory
You will get a folder named "pyGIS-main"

===============================================================================

## Step 2: Download Miniforge3

**EASIEST METHOD - Use your browser:**

1. Go to: https://github.com/conda-forge/miniforge/releases/latest/
2. **For Intel Macs:** Click on `Miniforge3-MacOSX-x86_64.sh` to download
3. **For Apple Silicon Macs (M1/M2/M3):** Click on `Miniforge3-MacOSX-arm64.sh` to download
4. The file will download to your Downloads folder

**To check which Mac you have:** Click Apple menu → About This Mac
- If you see "Intel" → use x86_64 version
- If you see "Apple M1", "Apple M2", or "Apple M3" → use arm64 version

**Alternative (Terminal method):**
If you prefer using Terminal and have curl:
```bash
# For Intel Macs:
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-x86_64.sh

# For Apple Silicon Macs:
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
```

===============================================================================

## Step 3: Install Miniforge3

Open Terminal (Cmd+Space, type "Terminal", press Enter)

Navigate to where you downloaded the file ( example: Downloads folder):

cd ~/Downloads


Make the installer executable and run it:

**For Intel Macs:**

chmod +x Miniforge3-MacOSX-x86_64.sh
./Miniforge3-MacOSX-x86_64.sh


**For Apple Silicon Macs (M1/M2/M3):**

chmod +x Miniforge3-MacOSX-arm64.sh
./Miniforge3-MacOSX-arm64.sh


During installation you will see:

1. Press Enter to continue reading license
2. Press Enter again after reading license  
3. Type "yes" and press Enter to accept license
4. Press Enter to accept default installation location (`/Users/yourusername/miniforge3`)
5. You may see a PYTHONPATH warning - ignore this warning

!! CAREFUL!!

When asked "Do you wish to update your shell profile to automatically initialize conda?" - Type "NO" and press Enter

Installation will complete with "Thank you for installing Miniforge3!" message.



## Step 4: Initialize Miniforge3 Manually

Since you chose "no" during installation, run these commands:


eval "$(/Users/$USER/miniforge3/bin/conda shell.bash hook)"
conda init


**For different shells:**
- If using zsh (default on macOS Catalina+): `conda init zsh`
- If using bash: `conda init bash`

Then reload your shell:


exec zsh -l     # for zsh


Test if mamba is working:

mamba --version


You should see a version number like "mamba 2.1.1"

===============================================================================

## Step 5: Create PyGIS Environment

Navigate to the mac setup folder 


cd pyGIS-main/setup_files/mac


Create environment from YAML file:

mamba env create -f environment.yaml


Press "y" to proceed with installation.

This installs Python and 50+ geospatial packages. 

===============================================================================

## Step 6: Activate Environment

First, deactivate any current environment: [IF RAN ERROR] JUST SKIP THIS AND INITIALIZE THE CURRENT SHELL USING NEXT STEP

conda deactivate


To initialize the current shell, run:

eval "$(mamba shell hook --shell bash)"

*Note: Replace "bash" with "zsh" if you're using zsh*


Then activate the PyGIS environment:

mamba activate pygis_base


Your prompt should now show `(pygis_base)` at the beginning of each line.

===============================================================================

## Step 7: Test Installation


python -c 'import geopandas, rasterio, geowombat, jupyter; print("All packages working!")'


You should see: "All packages working!"

**SUCCESS!** 

===============================================================================

## Step 8: Navigate to Learning Materials

Go back to the main repository folder:

cd ../..  # This takes you to pyGIS-main/

Now you're ready to start learning!

RECOMMENDED FIRST STEP: Run the organization notebook:
jupyter lab FOLDER_Management.ipynb

This will organize all notebooks into structured folders for easier navigation.

===============================================================================
## Daily Usage

Every time you want to use PyGIS:

1. Open Terminal (Cmd+Space, type "Terminal", press Enter)
2. `mamba activate pygis_base`
3. `jupyter lab`
4. FIRST TIME: Run "folder_management.ipynb" to organize notebooks
5. Then open any .ipynb notebook and start learning!

===============================================================================

## Daily Workflow Summary:

mamba activate pygis_base
cd pyGIS-main
jupyter lab


===============================================================================

## macOS-Specific Notes:

- **Apple Silicon Macs (M1/M2/M3):** Make sure you downloaded the ARM64 version of Miniforge3
- **Shell:** macOS Catalina+ uses zsh by default, older versions use bash
- **Terminal:** Open with Cmd+Space → "Terminal" or Applications → Utilities → Terminal
- **Homebrew:** May be needed for some dependencies if not already installed
- **Xcode Command Line Tools:** May be required for some packages:
  ```bash
  xcode-select --install
  ```