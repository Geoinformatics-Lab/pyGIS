#!/bin/bash

# PyGILE Comprehensive Geospatial Environment Entrypoint

set -e

# Display environment info
echo "========================================"
echo "pyGILE_base Comprehensive Environment"
echo "========================================"
echo "Python version: $(python --version)"
echo "GDAL version: $(gdalinfo --version)"
echo "Working directory: $(pwd)"
echo "========================================"

# Activate conda base environment
source /opt/conda/etc/profile.d/conda.sh
conda activate base

# Test core geospatial packages
echo "Testing core geospatial packages..."
python -c "
import sys
packages = [
    'gdal', 'geopandas', 'rasterio', 'shapely', 'fiona', 
    'pyproj', 'folium', 'contextily', 'geowombat',
    'matplotlib', 'numpy', 'pandas', 'jupyter'
]
failed = []
for pkg in packages:
    try:
        __import__(pkg)
        print(f'✓ {pkg}')
    except ImportError as e:
        print(f'✗ {pkg}: {e}')
        failed.append(pkg)

if failed:
    print(f'WARNING: {len(failed)} packages failed to import')

else:
    print('SUCCESS: All core packages working!')
"

# Set up Jupyter configuration
mkdir -p /root/.jupyter
cat > /root/.jupyter/jupyter_lab_config.py << EOF
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.allow_root = True
c.ServerApp.token = ''
c.ServerApp.password = ''
c.ServerApp.notebook_dir = '/workspace'
EOF

# Create sample notebooks directory
mkdir -p /workspace/notebooks
mkdir -p /workspace/data

# Create a welcome notebook
cat > /workspace/notebooks/Welcome.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Welcome to pyGILE_base Comprehensive Environment\n",
    "\n",
    "This Docker container includes the most comprehensive collection of geospatial Python packages available.\n",
    "\n",
    "## Quick Test"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Test core geospatial packages\n",
    "import geopandas as gpd\n",
    "import rasterio\n",
    "import folium\n",
    "import matplotlib.pyplot as plt\n",
    "import numpy as np\n",
    "\n",
    "print(\"All packages working!\")\n",
    "print(f\"GeoPandas version: {gpd.__version__}\")\n",
    "print(f\"Rasterio version: {rasterio.__version__}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Available Packages\n",
    "\n",
    "This environment includes:\n",
    "- **Core GIS**: GDAL, GeoPandas, Shapely, Fiona, PyProj\n",
    "- **Raster Analysis**: Rasterio, GeoWombat, Whitebox\n",
    "- **Visualization**: Folium, Contextily, HoloViews, GeoViews\n",
    "- **Earth Observation**: Satpy, PyResample\n",
    "- **Machine Learning**: TensorFlow, Scikit-learn, OpenCV\n",
    "- **Climate Data**: xESMF, CFGrib\n",
    "- **And many more...**"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "name": "python",
   "version": "3.10.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF

echo "========================================"
echo "Container ready! Starting Jupyter Lab..."
echo "========================================"

# Start Jupyter Lab
exec jupyter lab