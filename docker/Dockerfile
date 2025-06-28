# Use mambaforge as base image for faster conda package installation
FROM condaforge/mambaforge:latest

# Set maintainer info
LABEL maintainer="PyGILE Project"
LABEL description="Geospatial Python environment for PyGILE learning materials"

# Set environment variables
ENV CONDA_ENV_NAME=pygile_base
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /workspace

# Create environment step by step to avoid conflicts
RUN mamba create -n pygile_base python=3.10 -y && \
    mamba clean -afy

# Install core geospatial packages
RUN mamba install -n pygile_base -c conda-forge \
    gdal=3.6.2 proj=9.1.0 geos=3.11.1 libspatialindex \
    numpy=1.24.3 pandas scipy matplotlib seaborn scikit-learn \
    geopandas rasterio shapely pyproj fiona \
    xarray netcdf4 h5py h5netcdf \
    jupyter jupyterlab=4.4.3 ipywidgets \
    plotly folium contextily earthpy mapclassify geoplot \
    -y && mamba clean -afy

# Install geowombat separately (often problematic)
RUN mamba install -n pygile_base -c conda-forge geowombat=2.1.22 -y || \
    mamba install -n pygile_base -c conda-forge geowombat -y || \
    echo "Geowombat installation failed, will try pip later"

# Install additional pip packages that might not be in conda-forge
RUN conda run -n pygile_base pip install --no-cache-dir \
    sympy==1.14.0 \
    numpy-groupies==0.11.2 \
    jupyter-book==1.0.4 \
    geojson==3.2.0 \
    pykrige==1.7.2 \
    sklearn-xarray==0.4.0

# Set up Jupyter kernel
RUN conda run -n pygile_base python -m ipykernel install --user --name pygile_base --display-name "Python (pygile_base)"

# Create notebook directory
RUN mkdir -p /workspace/notebooks

# Set the default conda environment
ENV PATH=/opt/conda/envs/pygile_base/bin:$PATH
ENV CONDA_DEFAULT_ENV=pygile_base

# Copy and setup entrypoint script (proper way - avoid RUN echo issues)
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && sed -i 's/\r$//' /usr/local/bin/entrypoint.sh

# Expose Jupyter port
EXPOSE 8888

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command (starts Jupyter)
CMD []