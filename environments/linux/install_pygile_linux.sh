#!/bin/bash

# Enhanced PyGILE installer for Linux - with progress tracking and timeouts
set -e  # Exit on error, but we'll handle errors manually

echo ""
echo "============================================================"
echo "      ENHANCED PYGILE BASE ENVIRONMENT INSTALLER"
echo "============================================================"
echo ""

LOGFILE="pygile_installation.log"
ERRORLOG="pygile_errors.log"
ERROR_COUNT=0
SUCCESS_COUNT=0
GEOWOMBAT_SUCCESS=0

echo "Starting installation at $(date)"
echo "Log file: $LOGFILE"
echo "Error log: $ERRORLOG"
echo ""

# Clear previous logs
echo "Installation started at $(date)" > "$LOGFILE"
echo "Error summary" > "$ERRORLOG"

# ============================================================
# Find conda installation
# ============================================================
echo "[1/30] Searching for conda installation... [3%]"
CONDA_EXE=""
MAMBA_EXE=""

# Check common conda locations
if command -v mamba &> /dev/null; then
    MAMBA_EXE=$(which mamba)
elif command -v conda &> /dev/null; then
    CONDA_EXE=$(which conda)
elif [ -f "$HOME/miniforge3/bin/conda" ]; then
    CONDA_EXE="$HOME/miniforge3/bin/conda"
    [ -f "$HOME/miniforge3/bin/mamba" ] && MAMBA_EXE="$HOME/miniforge3/bin/mamba"
elif [ -f "$HOME/miniconda3/bin/conda" ]; then
    CONDA_EXE="$HOME/miniconda3/bin/conda"
    [ -f "$HOME/miniconda3/bin/mamba" ] && MAMBA_EXE="$HOME/miniconda3/bin/mamba"
elif [ -f "/opt/conda/bin/conda" ]; then
    CONDA_EXE="/opt/conda/bin/conda"
    [ -f "/opt/conda/bin/mamba" ] && MAMBA_EXE="/opt/conda/bin/mamba"
fi

if [ -z "$CONDA_EXE" ] && [ -z "$MAMBA_EXE" ]; then
    echo "ERROR: Could not find conda or mamba installation!"
    echo "Please install miniforge first"
    exit 1
fi

if [ -n "$MAMBA_EXE" ]; then
    INSTALLER="$MAMBA_EXE"
    echo "Found mamba - using for faster installation"
else
    INSTALLER="$CONDA_EXE"
    echo "Found conda - using for installation"
fi

echo "Found: $INSTALLER" >> "$LOGFILE"

# ============================================================
# Install package function with timeout and progress
# ============================================================
install_package() {
    local package="$1"
    local step="$2"
    local total="$3"
    local description="$4"
    
    echo "[$step/$total] Installing $description: $package"
    
    # Use timeout to prevent hanging (5 minutes max per package)
    set +e  # Don't exit on error for individual packages
    if timeout 300 "$INSTALLER" install -n pygile_base --override-channels -c conda-forge "$package" -y 2>&1 | tee -a "$LOGFILE"; then
        echo "✓ SUCCESS: $package"
        ((SUCCESS_COUNT++))
        local result=0
    else
        echo "✗ FAILED/TIMEOUT: $package"
        echo "FAILED: $package" >> "$ERRORLOG"
        ((ERROR_COUNT++))
        local result=1
    fi
    set -e  # Re-enable exit on error
    
    echo "Progress: $SUCCESS_COUNT successes, $ERROR_COUNT failures"
    echo "---"
    return $result
}

# Install pip package function
install_pip_package() {
    local package="$1"
    local step="$2"
    local total="$3"
    local description="$4"
    
    echo "[$step/$total] Installing $description via pip: $package"
    
    set +e
    if timeout 300 "$INSTALLER" run -n pygile_base pip install "$package" 2>&1 | tee -a "$LOGFILE"; then
        echo "✓ SUCCESS (pip): $package"
        ((SUCCESS_COUNT++))
        local result=0
    else
        echo "✗ FAILED (pip): $package"
        echo "PIP FAILED: $package" >> "$ERRORLOG"
        ((ERROR_COUNT++))
        local result=1
    fi
    set -e
    
    echo "Progress: $SUCCESS_COUNT successes, $ERROR_COUNT failures"
    echo "---"
    return $result
}

# ============================================================
# Clean conda cache
# ============================================================
echo "[1.5/30] Cleaning conda cache for fresh installation... [5%]"
"$INSTALLER" clean --all -y &>/dev/null || true
echo "Cache cleaned for consistent package versions"

# ============================================================
# Remove existing environment
# ============================================================
echo "[2/30] Cleaning up existing environment... [7%]"
"$INSTALLER" env remove -n pygile_base -y &>/dev/null || true
echo "Environment cleanup completed"

# ============================================================
# Create base environment
# ============================================================
echo "[3/30] Creating pygile_base environment with Python 3.10... [10%]"
set +e
if timeout 300 "$INSTALLER" create -n pygile_base --override-channels -c conda-forge python=3.10 -y 2>&1 | tee -a "$LOGFILE"; then
    echo "✓ Base environment created successfully"
    ((SUCCESS_COUNT++))
else
    echo "✗ CRITICAL: Base environment creation failed"
    echo "CRITICAL: Base environment creation failed" >> "$ERRORLOG"
    ((ERROR_COUNT++))
    echo "Cannot continue without base environment. Exiting."
    exit 1
fi
set -e

# ============================================================
# Install packages step by step
# ============================================================

# NumPy with compatibility constraint (CRITICAL FOR GEOWOMBAT)
echo "[4/30] Installing NumPy with compatibility constraint... [13%]"
if ! install_package "numpy<2" "4" "30" "NumPy compatibility"; then
    echo "Trying NumPy fallback version..."
    install_package "numpy=1.24.3" "4b" "30" "NumPy 1.24.3 fallback"
fi

# Core geospatial libraries
install_package "gdal=3.6.2" "5" "30" "GDAL"
install_package "proj=9.1.0" "6" "30" "PROJ"
install_package "geos=3.11.1" "7" "30" "GEOS"
install_package "libspatialindex" "8" "30" "Spatial Index"

# Core scientific stack
install_package "pandas" "9" "30" "Pandas"
install_package "scipy" "10" "30" "SciPy"
install_package "matplotlib" "11" "30" "Matplotlib"
install_package "seaborn" "12" "30" "Seaborn"
install_package "scikit-learn" "13" "30" "Scikit-learn"

# Geospatial core packages
install_package "fiona" "14" "30" "Fiona"
install_package "shapely" "15" "30" "Shapely"
install_package "pyproj" "16" "30" "PyProj"
install_package "geopandas" "17" "30" "GeoPandas"
install_package "rasterio" "18" "30" "Rasterio"

# Data formats
install_package "xarray" "19" "30" "XArray"
install_package "netcdf4" "20" "30" "NetCDF4"
install_package "h5py" "21" "30" "HDF5"
install_package "h5netcdf" "22" "30" "H5NetCDF"

# Jupyter ecosystem
install_package "jupyter" "23" "30" "Jupyter"
install_package "jupyterlab=4.4.3" "24" "30" "JupyterLab"
install_package "ipywidgets" "25" "30" "IPython Widgets"

# Visualization packages
install_package "plotly" "26" "30" "Plotly"
install_package "folium" "27" "30" "Folium"
install_package "contextily" "28" "30" "Contextily"
install_package "mapclassify" "29" "30" "Map Classify"

# ============================================================
# Install Geowombat with fallback strategies including GitHub
# ============================================================
echo "[30/30] Installing Geowombat with compatibility settings... [100%]"
echo "Attempting Geowombat installation with multiple fallback strategies..."

set +e
# Strategy 1: Conda with version pin
if timeout 300 "$INSTALLER" install -n pygile_base --override-channels -c conda-forge geowombat=2.1.22 -y 2>&1 | tee -a "$LOGFILE"; then
    echo "✓ SUCCESS: Geowombat 2.1.22 via conda-forge"
    GEOWOMBAT_SUCCESS=1
    ((SUCCESS_COUNT++))
else
    echo "Conda 2.1.22 failed, trying conda without version pin..."
    
    # Strategy 2: Conda without version pin
    if timeout 300 "$INSTALLER" install -n pygile_base --override-channels -c conda-forge geowombat -y 2>&1 | tee -a "$LOGFILE"; then
        echo "✓ SUCCESS: Geowombat latest via conda-forge"
        GEOWOMBAT_SUCCESS=1
        ((SUCCESS_COUNT++))
    else
        echo "Conda install failed, trying GitHub installation..."
        
        # Strategy 3: GitHub installation (most reliable)
        if timeout 300 "$INSTALLER" run -n pygile_base pip install "git+https://github.com/jgrss/geowombat.git" 2>&1 | tee -a "$LOGFILE"; then
            echo "✓ SUCCESS: Geowombat latest from GitHub (most up-to-date)"
            GEOWOMBAT_SUCCESS=1
            ((SUCCESS_COUNT++))
        else
            echo "GitHub install failed, trying pip with specific version..."
            
            # Strategy 4: Pip with specific version
            if timeout 300 "$INSTALLER" run -n pygile_base pip install geowombat==2.0.6 2>&1 | tee -a "$LOGFILE"; then
                echo "✓ SUCCESS: Geowombat 2.0.6 via pip (pyGIS compatible)"
                GEOWOMBAT_SUCCESS=1
                ((SUCCESS_COUNT++))
            else
                echo "Pip 2.0.6 failed, trying latest PyPI version..."
                
                # Strategy 5: Pip latest
                if timeout 300 "$INSTALLER" run -n pygile_base pip install geowombat 2>&1 | tee -a "$LOGFILE"; then
                    echo "✓ SUCCESS: Geowombat latest via pip"
                    GEOWOMBAT_SUCCESS=1
                    ((SUCCESS_COUNT++))
                else
                    echo "Latest failed, trying --no-build-isolation..."
                    
                    # Strategy 6: Pip with no build isolation
                    if timeout 300 "$INSTALLER" run -n pygile_base pip install geowombat --no-build-isolation 2>&1 | tee -a "$LOGFILE"; then
                        echo "✓ SUCCESS: Geowombat via pip with --no-build-isolation"
                        GEOWOMBAT_SUCCESS=1
                        ((SUCCESS_COUNT++))
                    else
                        echo "✗ WARNING: All Geowombat installation attempts failed"
                        echo "FAILED: Geowombat all attempts" >> "$ERRORLOG"
                        ((ERROR_COUNT++))
                    fi
                fi
            fi
        fi
    fi
fi
set -e

# ============================================================
# Install additional pip packages
# ============================================================
echo ""
echo "Installing additional packages via pip..."

# Install pip packages with error handling and GitHub fallbacks
pip_packages=(
    "sympy==1.14.0:SymPy symbolic math"
    "numpy-groupies==0.11.2:NumPy groupies"
    "jupyter-book==1.0.4:Jupyter Book"
    "geojson==3.2.0:GeoJSON"
    "dask-geopandas==0.4.3:Dask GeoPandas"
    "pykrige==1.7.2:PyKrige"
    "cenpy==1.0.1:CenPy census data"
    "census==0.8.24:Census API"
    "us==3.2.0:US states data"
)

# GitHub fallback packages (packages that often have conda issues)
github_packages=(
    "sklearn-xarray:git+https://github.com/jgrss/sklearn-xarray.git:Custom sklearn-xarray (pyGIS compatible)"
    "earthpy:earthpy:EarthPy geospatial utils"
    "osmnx:osmnx:OpenStreetMap network analysis"
    "contextily:contextily:Contextily basemaps"
)

step_counter=31
for package_info in "${pip_packages[@]}"; do
    IFS=":" read -r package description <<< "$package_info"
    install_pip_package "$package" "$step_counter" "45" "$description"
    ((step_counter++))
done

# Install packages with GitHub fallbacks
echo ""
echo "Installing packages with GitHub fallbacks for reliability..."
for package_info in "${github_packages[@]}"; do
    IFS=":" read -r package_name github_source description <<< "$package_info"
    
    echo "[$step_counter/45] Installing $description..."
    
    # Try conda first
    set +e
    if timeout 180 "$INSTALLER" install -n pygile_base --override-channels -c conda-forge "$package_name" -y 2>&1 | tee -a "$LOGFILE"; then
        echo "✓ SUCCESS: $package_name via conda-forge"
        ((SUCCESS_COUNT++))
    else
        echo "Conda failed for $package_name, trying GitHub..."
        
        # Fallback to GitHub installation
        if [ "$github_source" != "$package_name" ]; then
            # Custom GitHub URL provided
            if timeout 300 "$INSTALLER" run -n pygile_base pip install "$github_source" 2>&1 | tee -a "$LOGFILE"; then
                echo "✓ SUCCESS: $package_name from GitHub (latest development version)"
                ((SUCCESS_COUNT++))
            else
                echo "GitHub failed, trying standard pip..."
                if timeout 180 "$INSTALLER" run -n pygile_base pip install "$package_name" 2>&1 | tee -a "$LOGFILE"; then
                    echo "✓ SUCCESS: $package_name via pip"
                    ((SUCCESS_COUNT++))
                else
                    echo "✗ FAILED: $package_name (all methods)"
                    echo "FAILED: $package_name" >> "$ERRORLOG"
                    ((ERROR_COUNT++))
                fi
            fi
        else
            # Standard package, just try pip
            if timeout 180 "$INSTALLER" run -n pygile_base pip install "$package_name" 2>&1 | tee -a "$LOGFILE"; then
                echo "✓ SUCCESS: $package_name via pip"
                ((SUCCESS_COUNT++))
            else
                echo "✗ FAILED: $package_name"
                echo "FAILED: $package_name" >> "$ERRORLOG"
                ((ERROR_COUNT++))
            fi
        fi
    fi
    set -e
    
    echo "Progress: $SUCCESS_COUNT successes, $ERROR_COUNT failures"
    echo "---"
    ((step_counter++))
done

# ============================================================
# Verification
# ============================================================
echo ""
echo "============================================================"
echo "                    VERIFICATION"
echo "============================================================"

echo "Verifying core packages..."
set +e
if timeout 60 "$INSTALLER" run -n pygile_base python -c "import numpy, pandas, geopandas, rasterio, matplotlib; print('✓ Core packages working')" 2>&1 | tee -a "$LOGFILE"; then
    echo "✓ Core package verification successful"
    ((SUCCESS_COUNT++))
else
    echo "✗ Core package verification failed"
    echo "VERIFY FAILED: Core packages" >> "$ERRORLOG"
    ((ERROR_COUNT++))
fi

if [ $GEOWOMBAT_SUCCESS -eq 1 ]; then
    echo "Verifying Geowombat..."
    if timeout 60 "$INSTALLER" run -n pygile_base python -c "import geowombat as gw; print(f'✓ Geowombat version: {gw.__version__}')" 2>&1 | tee -a "$LOGFILE"; then
        echo "✓ Geowombat verification successful"
        ((SUCCESS_COUNT++))
    else
        echo "✗ Geowombat verification failed (but may still work)"
        echo "VERIFY FAILED: Geowombat" >> "$ERRORLOG"
    fi
fi
set -e

# ============================================================
# Final Report
# ============================================================
echo ""
echo "============================================================"
echo "                   INSTALLATION COMPLETE"
echo "============================================================"
echo "Installation finished at $(date)"
echo ""

TOTAL_ATTEMPTED=40
SUCCESS_RATE=$((SUCCESS_COUNT * 100 / TOTAL_ATTEMPTED))

echo "SUMMARY:"
echo "- Successful installations: $SUCCESS_COUNT/$TOTAL_ATTEMPTED ($SUCCESS_RATE%)"
echo "- Issues encountered: $ERROR_COUNT"
echo ""

if [ $SUCCESS_COUNT -ge 25 ]; then
    echo "SUCCESS: Core PyGILE environment ready for use!"
    echo ""
    echo "============================================================"
    echo "                    HOW TO USE YOUR ENVIRONMENT"
    echo "============================================================"
    echo ""
    echo "TO START WORKING:"
    echo "1. conda deactivate    (if you see 'base' in your prompt)"
    echo "2. conda activate pygile_base"
    echo "3. jupyter lab"
    echo ""
    echo "DAILY USAGE:"
    echo "1. Open Terminal"
    echo "2. conda activate pygile_base"
    echo "3. jupyter lab"
    echo ""
    echo "INSTALLED CORE TOOLS:"
    echo "- Python 3.10 with compatibility settings"
    echo "- GeoPandas for vector data analysis"
    echo "- Rasterio for raster data processing"
    echo "- NumPy, Pandas, SciPy for data science"
    echo "- Matplotlib, Plotly for visualization"
    echo "- Jupyter Lab for interactive notebooks"
    echo "- Folium, Contextily for web mapping"
    [ $GEOWOMBAT_SUCCESS -eq 1 ] && echo "- Geowombat for advanced raster processing"
    echo "- And many more geospatial tools!"
    echo ""
else
    echo "PARTIAL SUCCESS: Environment created with some issues"
    echo ""
    echo "Most core functionality should still work."
    echo "Check $ERRORLOG for detailed error information."
    echo ""
    echo "TO START WORKING ANYWAY:"
    echo "1. conda deactivate    (if you see 'base' in your prompt)"
    echo "2. conda activate pygile_base"
    echo "3. jupyter lab"
    echo ""
    echo "You can try manually installing failed packages later if needed."
    echo ""
fi

echo "TROUBLESHOOTING:"
echo "- If packages fail to import, try: conda activate pygile_base"
echo "- For conda issues, try: conda clean --all"
echo "- For environment issues, you can re-run this script"
echo ""
echo "Installation logs saved to: $LOGFILE"
echo "Error summary saved to: $ERRORLOG"
echo ""
echo "Press any key to continue..."
read -n 1 -s