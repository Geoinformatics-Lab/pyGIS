#!/bin/bash

# PyGILE installer for macOS - skips failures, continues with others

LOGFILE="pygile_install.log"
ERRORLOG="pygile_errors.log"
SUCCESS_COUNT=0
ERROR_COUNT=0

# Find conda/mamba executable
if command -v mamba &> /dev/null; then
    INSTALLER="mamba"
elif command -v conda &> /dev/null; then
    INSTALLER="conda"
else
    echo "Error: Neither conda nor mamba found"
    exit 1
fi

# Force conda-forge channel priority for macOS compatibility
$INSTALLER config --add channels conda-forge
$INSTALLER config --set channel_priority strict

echo "Starting PyGILE installation using $INSTALLER"
echo "Installation started at $(date)" > "$LOGFILE"
echo "Error summary" > "$ERRORLOG"

# Remove existing environment
$INSTALLER env remove -n pygile_base -y &>/dev/null

# Install package function with fallback for architecture issues
install_package() {
    local package="$1"
    if $INSTALLER install -n pygile_base -c conda-forge "$package" -y &>> "$LOGFILE"; then
        ((SUCCESS_COUNT++))
    else
        # Try without version constraint for Apple Silicon compatibility
        local base_package=$(echo "$package" | cut -d'=' -f1)
        if [[ "$package" != "$base_package" ]]; then
            if $INSTALLER install -n pygile_base -c conda-forge "$base_package" -y &>> "$LOGFILE"; then
                echo "FALLBACK SUCCESS: $base_package (version constraint removed)" >> "$LOGFILE"
                ((SUCCESS_COUNT++))
                return 0
            fi
        fi
        echo "FAILED: $package" >> "$ERRORLOG"
        ((ERROR_COUNT++))
    fi
}

# Install pip package function
install_pip_package() {
    local package="$1"
    if $INSTALLER run -n pygile_base pip install "$package" &>> "$LOGFILE"; then
        ((SUCCESS_COUNT++))
    else
        echo "PIP FAILED: $package" >> "$ERRORLOG"
        ((ERROR_COUNT++))
    fi
}

# Create base environment
echo "Creating base environment"
if ! $INSTALLER create -n pygile_base -c conda-forge python=3.10 -y >> "$LOGFILE" 2>&1; then
    echo "CRITICAL: Failed to create base environment"
    exit 1
fi

# System dependencies
system_packages=(
    "gdal=3.6.2"
    "proj=9.1.0"
    "geos=3.11.1"
    "libspatialindex"
    "boost-cpp"
)

# Core scientific stack
scientific_packages=(
    "numpy=1.24.3"
    "pandas"
    "scipy"
    "matplotlib"
    "seaborn"
    "scikit-learn"
)

# Geospatial core
geospatial_core_packages=(
    "geopandas"
    "rasterio"
    "shapely"
    "pyproj"
    "fiona"
)

# Geospatial extras
geospatial_extra_packages=(
    "contextily"
    "folium"
    "osmnx"
    "earthpy"
    "mapclassify"
    "geoplot"
    "geowombat=2.1.22"
)

# Data formats
data_format_packages=(
    "h5py"
    "netcdf4"
    "h5netcdf"
    "xarray"
)

# Visualization
visualization_packages=(
    "plotly"
)

# Jupyter
jupyter_packages=(
    "jupyter"
    "jupyterlab=4.4.3"
    "ipywidgets"
)

# Pip dependencies
pip_dependencies=(
    "pip"
)

# Pip packages
pip_packages=(
    "sympy==1.14.0"
    "numpy-groupies==0.11.2"
    "jupyter-book==1.0.4"
    "geojson==3.2.0"
    "dask-geopandas==0.4.3"
    "pykrige==1.7.2"
    "cenpy==1.0.1"
    "census==0.8.24"
    "us==3.2.0"
    "sklearn-xarray==0.4.0"
)

echo "Installing system dependencies"
for package in "${system_packages[@]}"; do
    install_package "$package"
done

echo "Installing core scientific stack"
for package in "${scientific_packages[@]}"; do
    install_package "$package"
done

echo "Installing geospatial core packages"
for package in "${geospatial_core_packages[@]}"; do
    install_package "$package"
done

echo "Installing geospatial extras"
for package in "${geospatial_extra_packages[@]}"; do
    install_package "$package"
done

echo "Installing data format packages"
for package in "${data_format_packages[@]}"; do
    install_package "$package"
done

echo "Installing visualization packages"
for package in "${visualization_packages[@]}"; do
    install_package "$package"
done

echo "Installing Jupyter packages"
for package in "${jupyter_packages[@]}"; do
    install_package "$package"
done

echo "Installing pip dependencies"
for package in "${pip_dependencies[@]}"; do
    install_package "$package"
done

# Install pip packages
echo "Installing pip packages"
for package in "${pip_packages[@]}"; do
    install_pip_package "$package"
done

# Summary
TOTAL=$((${#system_packages[@]} + ${#scientific_packages[@]} + ${#geospatial_core_packages[@]} + ${#geospatial_extra_packages[@]} + ${#data_format_packages[@]} + ${#visualization_packages[@]} + ${#jupyter_packages[@]} + ${#pip_dependencies[@]} + ${#pip_packages[@]}))
echo "Installation complete: $SUCCESS_COUNT/$TOTAL packages installed"
echo "Failed packages: $ERROR_COUNT (see $ERRORLOG)"

# Test installation
if $INSTALLER run -n pygile_base python -c "import geopandas, rasterio; print('Core packages working')" &>/dev/null; then
    echo "SUCCESS: Environment ready for use"
else
    echo "WARNING: Core packages verification failed"
fi