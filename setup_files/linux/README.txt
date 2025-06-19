PyGIS Setup for Linux

Complete Python environment for geospatial analysis

===============================================================================

Step 1: Download and Extract Repository

Go to: https://github.com/Geoinformatics-Lab/pyGIS
Click green "Code" button -> "Download ZIP"
Extract the ZIP file to your home directory
You will get a folder named "pyGIS-main"
===============================================================================

Step 2: Download Miniforge3

Open Terminal (Ctrl+Alt+T) and run:

wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh

===============================================================================

Step 3: Install Miniforge3

chmod +x Miniforge3-Linux-x86_64.sh
./Miniforge3-Linux-x86_64.sh

During installation you will see:

1. Press Enter to continue reading license
2. Press Enter again after reading license  
3. Type "yes" and press Enter to accept license
4. Press Enter to accept default installation location
5. You will see a PYTHONPATH warning - ignore this warning

      !!!CAREFUL!!!

6. When asked "Do you wish to update your shell profile to automatically initialize conda?" - Type "no" and press Enter


Installation will complete with "Thank you for installing Miniforge3!" message.

===============================================================================

Step 4: Initialize Miniforge3 Manually

Since you chose "no" during installation, run these commands:

eval "$(/home/$USER/miniforge3/bin/conda shell.bash hook)"
conda init
source ~/.bashrc

Test if mamba is working:
mamba --version

You should see a version number like "mamba 2.1.1"

===============================================================================

Step 5: Create PyGIS Environment

Navigate to the linux setup folder:

cd pyGIS-main/setup_files/linux

Create environment from YAML file:
mamba env create -f environment.yaml

Press "y"; to proceed installation

This installs Python and 50+ geospatial packages. 

===============================================================================

Step 6: To Activate Environment

First, type "conda deactivate"

Then, 

To initialize the current bash shell, run:
    $ eval "$(mamba shell hook --shell bash)"

The,

mamba activate pygis_base

Your prompt should now show (pygis_base) at the beginning of each line.

# Install ipykernel to make your environment available in Jupyter
conda install ipykernel

# Register your current environment with Jupyter
python -m ipykernel install --user --name pygis_base --display-name "Python (pygis_base)“

# Then restart Jupyter Lab
jupyter lab


===============================================================================

Step 7: Test Installation

python -c 'import geopandas, rasterio, geowombat, jupyter; print("All packages working!")'

You should see: "All packages working!"

SUCCESS! 


===============================================================================

Step 8: Navigate to Learning Materials

Go back to the main repository folder:

cd ../..  # This takes you to pyGIS-main/

Now you're ready to start learning!

RECOMMENDED FIRST STEP: Run the organization notebook:
jupyter lab FOLDER_Management.ipynb

This will organize all notebooks into structured folders for easier navigation.

===============================================================================
QUICK START (After First-Time Setup):

1. Open Terminal
2. mamba activate pygis_base  
3. cd pyGIS-main
4. jupyter lab
5. FIRST TIME: Run "folder_management.ipynb" to organize notebooks
6. Then open any .ipynb notebook and start learning!

===============================================================================