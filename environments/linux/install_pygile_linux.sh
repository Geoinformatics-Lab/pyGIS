#!/bin/bash

# PyGILE installer - skips failures, continues with others

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

echo "Starting PyGILE installation using $INSTALLER"
echo "Installation started at $(date)" > "$LOGFILE"
echo "Error summary" > "$ERRORLOG"

# Remove existing environment
$INSTALLER env remove -n pygile_base -y &>/dev/null

# Install package function
install_package() {
    local package="$1"
    if $INSTALLER install -n pygile_base -c conda-forge "$package" -y &>> "$LOGFILE"; then
        ((SUCCESS_COUNT++))
    else
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

# Core packages
core_packages=(
    "gdal=3.6.2"
    "proj=9.1.0"
    "geos=3.11.1"
    "libspatialindex"
    "boost-cpp"
    "numpy=1.24.3"
    "pandas"
    "scipy"
    "matplotlib"
    "seaborn"
    "scikit-learn"
    "geopandas"
    "rasterio"
    "shapely"
    "pyproj"
    "fiona"
    "contextily"
    "folium"
    "osmnx"
    "earthpy"
    "mapclassify"
    "geoplot"
    "geowombat=2.1.22"
    "dask-geopandas=0.4.3"
    "cenpy=1.0.1"
    "census=0.8.24"
    "us=3.2.0"
    "h5py"
    "netcdf4"
    "h5netcdf"
    "xarray"
    "plotly"
    "jupyter"
    "jupyterlab=4.4.3"
    "ipywidgets"
)

# Additional packages
additional_packages=(
    "bokeh"
    "scikit-image"
    "imageio-ffmpeg"
    "tifffile"
    "zarr"
    "rio-cogeo"
    "rioxarray"
    "ipyleaflet"
    "leafmap"
    "geemap"
    "localtileserver"
    "pystac"
    "stackstac"
    "planetary-computer"
    "palettable"
    "owslib"
)

# Pip packages
pip_packages=(
    "sympy==1.14.0"
    "numpy-groupies==0.11.2"
    "jupyter-book==1.0.4"
    "geojson==3.2.0"
    "pykrige==1.7.2"
    "sklearn-xarray==0.4.0"
    "sphinx"
    "sphinx-sitemap"
    "sphinxcontrib.bibtex"
    "sphinx-inline-tabs"
    "pydata-sphinx-theme"
    "ghp-import"
)

echo "Installing core packages"
for package in "${core_packages[@]}"; do
    install_package "$package"
done

echo "Installing additional packages"
for package in "${additional_packages[@]}"; do
    install_package "$package"
done

# Install pip packages
for package in "${pip_packages[@]}"; do
    install_pip_package "$package"
done

# Summary
TOTAL=$((${#core_packages[@]} + ${#additional_packages[@]} + ${#pip_packages[@]}))
echo "Installation complete: $SUCCESS_COUNT/$TOTAL packages installed"
echo "Failed packages: $ERROR_COUNT (see $ERRORLOG)"

# Test installation
if $INSTALLER run -n pygile_base python -c "import geopandas, rasterio; print('Core packages working')" &>/dev/null; then
    echo "SUCCESS: Environment ready for use"
else
    echo "WARNING: Core packages verification failed"
fi