# Pygile Environment Installation for Linux

===============================================================================

## Step 1: Download and Extract Repository

Go to: [https://github.com/Geoinformatics-Lab/PyGILE](https://github.com/Geoinformatics-Lab/PyGILE)

Click green "Code" button -> "Download ZIP"

Extract the ZIP file to your home directory

You will get a folder named "PyGILE-main"

===============================================================================

## Step 2: Download Miniforge3

Open Terminal (Ctrl+Alt+T) and run:

```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
```

===============================================================================

## Step 3: Install Miniforge3

```bash
chmod +x Miniforge3-Linux-x86_64.sh
./Miniforge3-Linux-x86_64.sh
```

During installation you will see:
1. Press Enter to continue reading license
2. Press Enter again after reading license  
3. Type "yes" and press Enter to accept license
4. Press Enter to accept default installation location
5. You will see a PYTHONPATH warning - ignore this warning

      **!!!CAREFUL!!!**

6. When asked "Do you wish to update your shell profile to automatically initialize conda?" - Type "no" and press Enter

Installation will complete with "Thank you for installing Miniforge3!" message.

===============================================================================

## Step 4: Initialize Miniforge3 Manually

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

===============================================================================

## Step 5A: Create PyGILE Environment Using Script

Navigate to the linux setup folder:

```bash
cd PyGILE-main/environments/linux
```

Make the script executable and run it:

```bash
chmod +x install_pygile_linux.sh
./install_pygile_linux.sh
```

The script will install packages individually and continue even if some packages fail. Check the logs for details:

```bash
cat pygile_install.log
cat pygile_errors.log
```

===============================================================================

## Step 5B: Create PyGILE Environment Using YAML

Navigate to the linux setup folder:

```bash
cd PyGILE-main/environments/linux
```

Create environment from YAML file:

```bash
mamba env create -f environment.yaml
```

Press "y" to proceed installation


===============================================================================

## Step 6: To Activate Environment

First, type:
```bash
conda deactivate
```

Then, to initialize the current bash shell, run:

```bash
eval "$(mamba shell hook --shell bash)"
```

Then:

```bash
mamba activate pygile_base
```

Your prompt should now show (pygile_base) at the beginning of each line.

Install ipykernel to make your environment available in Jupyter:

```bash
conda install ipykernel
```

Register your current environment with Jupyter:

```bash
python -m ipykernel install --user --name pygile_base --display-name "Python (pygile_base)"
```

Then restart Jupyter Lab:

```bash
jupyter lab
```

===============================================================================

## Step 7: Test Installation

```bash
python -c 'import geopandas, rasterio, geowombat, jupyter; print("All packages working!")'
```

You should see: "All packages working!"

**SUCCESS!**

===============================================================================

## Step 8: Navigate to Learning Materials

Go back to the main repository folder:

```bash
cd ../..  # This takes you to PyGILE-main/
```

Now you're ready to start learning!

===============================================================================

## QUICK START (After First-Time Setup):

1. Open Terminal
2. ```bash
   mamba activate pygile_base
   ```
3. ```bash
   cd PyGILE-main
   ```
4. ```bash
   jupyter lab
   ```
5. Then open any `.ipynb` notebook inside the "pyGILE notebooks" folder and start learning!

===============================================================================