# PyGILE Docker Environment

PyGILE (Python for Geographic Information and Learning Environment) is a comprehensive Docker-based geospatial analysis environment designed for education, research, and professional GIS work. This containerized solution eliminates the complexity of setting up geospatial Python environments and provides instant access to 50+ pre-configured packages.


## Prerequisites

- Docker Desktop installed on your computer
- 8GB RAM recommended
- 10GB free disk space

## How to Run the Container

### Basic Container Usage

1. Open Docker Desktop
2. Open Command Prompt or Terminal
3. Run this command:

```
docker run -p 8888:8888 iamvuon/pygile_docker:latest
```

4. Open your browser to: http://localhost:8888
5. Start using Jupyter Lab with all geospatial packages ready

### With Your Own Files (Recommended)

To save your work and access your files:

Windows:
```
docker run -p 8888:8888 -v C:\Users\YourName\Documents\PyGILE:/workspace/notebooks iamvuon/pygile_docker:latest
```

Mac/Linux:
```
docker run -p 8888:8888 -v ~/Documents/PyGILE:/workspace/notebooks iamvuon/pygile_docker:latest
```

## Running PyGILE Notebooks

### Method 1: Clone PyGILE Repository and Run

1. Clone the PyGILE repository:
```
git clone https://github.com/Geoinformatics-Lab/PyGILE.git
cd PyGILE
```

2. Run the container from the PyGILE folder:

Windows:
```
docker run -p 8888:8888 -v "%cd%":/workspace/notebooks iamvuon/pygile_docker:latest
```

Mac/Linux:
```
docker run -p 8888:8888 -v $(pwd):/workspace/notebooks iamvuon/pygile_docker:latest
```

3. Open http://localhost:8888 in your browser
4. Navigate to the notebooks folder to access all PyGILE tutorials

### Method 2: Upload Notebooks

1. Start the container:
```
docker run -p 8888:8888 iamvuon/pygile_docker:latest
```

2. Go to http://localhost:8888
3. Use the upload button in Jupyter Lab to add your notebook files

## Other Tasks with This Container

### Access Command Line

To use Python or other tools directly:
```
docker run -it iamvuon/pygile_docker:latest bash
```

### Install Additional Packages

Inside the container, you can install more packages:
```
pip install your-package-name
conda install your-package-name
```

### Use Different Port

If port 8888 is busy:
```
docker run -p 8889:8888 iamvuon/pygile_docker:latest
```
Then access: http://localhost:8889

### Copy Files to Container

```
docker run -d -p 8888:8888 --name pygile iamvuon/pygile_docker:latest
docker cp your-file.ipynb pygile:/workspace/notebooks/
```

## Included Software

### Core Geospatial Libraries
- GDAL 3.10.3 - Geospatial Data Abstraction Library
- GeoPandas - Geospatial data in pandas
- Rasterio - Raster data I/O
- Shapely - Geometric objects
- Fiona - Vector data I/O
- PyProj - Map projections

### Advanced Tools
- Geowombat 2.1.22 - Advanced raster processing
- OSMNX - Street network analysis
- Earth Engine API - Google Earth Engine
- Folium - Interactive web mapping
- Leafmap - Interactive geospatial analysis

### Scientific Computing
- Python 3.10
- NumPy, Pandas, SciPy
- Matplotlib, Plotly, Bokeh
- Scikit-learn
- Jupyter Lab 4.4.3

### Data Formats
- NetCDF4, HDF5, Zarr
- Census data tools
- STAC for satellite data

## System Requirements

Minimum:
- 4GB RAM
- 10GB free disk space
- Docker Desktop


## Troubleshooting

**Port already in use:**
```
docker run -p 8889:8888 iamvuon/pygile_docker:latest
```

**Container won't start:**
```
docker pull iamvuon/pygile_docker:latest
docker container prune
```

**Memory issues:**
- Increase Docker Desktop memory allocation to 4GB+
- Close other applications

## Support

- PyGILE Repository: https://github.com/Geoinformatics-Lab/PyGILE
- Docker Hub: https://hub.docker.com/r/iamvuon/pygile_docker
- Issues: https://github.com/Geoinformatics-Lab/PyGILE/issues

## License

This project is part of PyGILE and follows the same licensing terms.