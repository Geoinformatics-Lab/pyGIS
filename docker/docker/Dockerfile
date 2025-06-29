# Use OSGeo GDAL ubuntu-full as base - most comprehensive geospatial image available
FROM ghcr.io/osgeo/gdal:ubuntu-full-latest

# Maintainer info
LABEL maintainer="pyGILE Team"
LABEL description="pyGILE_base comprehensive geospatial analysis environment"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV CONDA_DIR=/opt/conda
ENV PATH=/opt/conda/bin:$PATH

# Install system dependencies and miniforge in one layer with cleanup
RUN apt-get update && \
    apt-get install -y wget curl git vim build-essential && \
    wget -O miniforge.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh && \
    bash miniforge.sh -b -p /opt/conda && \
    rm miniforge.sh && \
    /opt/conda/bin/conda clean -afy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure conda and install all packages in one layer with aggressive cleanup
RUN conda config --set channel_priority strict && \
    mamba install -n base -c conda-forge \
    python=3.10 numpy pandas scipy matplotlib \
    geopandas rasterio shapely pyproj fiona \
    xarray netcdf4 h5py zarr \
    plotly bokeh folium contextily \
    jupyter jupyterlab ipywidgets \
    osmnx earthpy \
    gdal \
    -y && \
    pip install --no-cache-dir \
    earthengine-api streamlit-folium nbconvert black flake8 \
    sympy jupyter-book geojson pykrige \
    git+https://github.com/jgrss/geowombat.git && \
    mamba clean -afy && \
    conda clean -afy && \
    pip cache purge && \
    rm -rf /opt/conda/pkgs/* && \
    rm -rf /tmp/* /var/tmp/* && \
    find /opt/conda -name "*.pyc" -delete && \
    find /opt/conda -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true

# Copy entrypoint script and fix line endings
COPY entrypoint.sh /usr/local/bin/
RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

# Create working directory
WORKDIR /workspace

# Expose Jupyter port
EXPOSE 8888

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]