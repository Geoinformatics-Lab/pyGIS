Pygile Environment Installation for Linux

===============================================================================

Step 1: Download and Extract Repository

Go to: https://github.com/Geoinformatics-Lab/PyGILE

Click green "Code" button -> "Download ZIP"

Extract the ZIP file to your home directory

You will get a folder named "PyGILE-main"
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

Step 5: Create PyGILE Environment

Navigate to the linux setup folder:

cd PyGILE-main/environments/linux

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
Then,

mamba activate pygile_base

Your prompt should now show (pygile_base) at the beginning of each line.

# Install ipykernel to make your environment available in Jupyter

conda install ipykernel

# Register your current environment with Jupyter

python -m ipykernel install --user --name pygile_base --display-name "Python (pygile_base)"

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

cd ../..  # This takes you to PyGILE-main/

Now you're ready to start learning!
===============================================================================

QUICK START (After First-Time Setup):
1. Open Terminal
2. mamba activate pygile_base  
3. cd PyGILE-main
4. jupyter lab
5. Then open any .ipynb notebook inside the "pyGILE notebooks" folder and start learning!
===============================================================================
