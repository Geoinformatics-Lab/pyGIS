# PyGILE Docker Environment

A complete geospatial Python environment for PyGILE learning materials, packaged as a Docker container.

##  Pre-built PyGILE Docker image

[Pre-built PyGILE Docker image](https://hub.docker.com/r/iamvuon/pygile_docker)

##  What's Included

The Dockerfile can be used to create Docker image of ready-to-use geospatial Python environment with:

- **Python 3.10** with conda/mamba package management
- **Core Geospatial Libraries**: GeoPandas, Rasterio, Shapely, Fiona, GDAL
- **Advanced Tools**: Geowombat, Earth Engine API, OSMNX
- **Scientific Stack**: NumPy, Pandas, SciPy, Matplotlib, Seaborn
- **Jupyter Environment**: JupyterLab 4.4.3 with geospatial extensions
- **Visualization**: Plotly, Folium, Contextily, Bokeh
- **50+ specialized geospatial packages**

##  Building your own Docker image

### Prerequisites
1. **Install Docker Desktop** from [docker.com](https://www.docker.com/products/docker-desktop/)
2. **Make sure Docker Desktop is running** (you should see the Docker whale icon in your system tray)

### Option 1: Using Pre-built Image (Recommended)

**Step 1:** Open a terminal/command prompt
- **Docker Desktop terminal:** Open Docker Desktop → Click the terminal icon **(Recommended)**
OR
- **Windows users:** Press `Win + R`, type `cmd`, press Enter
- **Mac users:** Press `Cmd + Space`, type "Terminal", press Enter  
- **Linux users:** Press `Ctrl + Alt + T`


**Step 2:** Copy and paste this command:
```bash
docker run -p 8888:8888 iamvuon/pygile_docker:latest
```

**Step 3:** Press Enter and wait for download to complete

**Step 4:** Open your web browser and go to: `http://localhost:8888`

**Step 5:** Copy the token from your terminal and paste it into Jupyter Lab

### Option 2: Build from Source (Advanced Users Only)

1. **Clone this repository (in Command Prompt/Terminal):**
   ```bash
   git clone https://github.com/Geoinformatics-Lab/PyGILE.git
   cd PyGILE/docker
   ```

2. **Build the Docker image (in Command Prompt/Terminal):**
   ```bash
   docker build -t pygile:local .
   ```

3. **Run the container (in Command Prompt/Terminal):**
   ```bash
   docker run -p 8888:8888 pygile:local
   ```

**Requirements:**
- Docker Desktop must be installed and running
- Commands are run in your system's command line (NOT inside Docker Desktop)

##  Usage Instructions

### Starting Jupyter Lab

1. **Run the container:**
   ```bash
   docker run -p 8888:8888 pygile:latest
   ```

2. **Access Jupyter Lab:**
   - Open your browser
   - Go to: `http://localhost:8888`
   - Use the token shown in the terminal output

### Working with Your Files

**Mount a local directory to save your work:**
```bash
docker run -p 8888:8888 -v /your/local/path:/workspace/notebooks pygile:latest
```

**Example (Windows):**
```bash
docker run -p 8888:8888 -v C:\Users\YourName\Documents\PyGILE:/workspace/notebooks pygile:latest
```

**Example (Mac/Linux):**
```bash
docker run -p 8888:8888 -v ~/Documents/PyGILE:/workspace/notebooks pygile:latest
```

### Advanced Usage

**Run with custom command:**
```bash
docker run -it pygile:latest bash  # Start interactive shell
```

**Run with Docker Compose:**
```yaml
version: '3.8'
services:
  pygile:
    image: pygile:latest
    ports:
      - "8888:8888"
    volumes:
      - ./notebooks:/workspace/notebooks
```

##  Development

### Building the Image

**Requirements:**
- Docker Desktop installed
- At least 8GB free disk space
- Stable internet connection

**Build process:**
```bash
cd docker/
docker build -t pygile:latest .
```

**Build time:** ~20-30 minutes (downloads and installs 50+ packages)

### Files Structure

```
docker/
├── Dockerfile          # Main build instructions
├── entrypoint.sh       # Startup script for Jupyter
└── README.md          # This file
```

##  Troubleshooting

### Port Already in Use
```bash
# Use a different port
docker run -p 8889:8888 pygile:latest
# Then access: http://localhost:8889
```

### Permission Issues (Linux/Mac)
```bash
# Run with your user ID
docker run -p 8888:8888 --user $(id -u):$(id -g) pygile:latest
```

### Container Won't Start
```bash
# Check container logs
docker logs <container_id>

# Start with bash to debug
docker run -it --entrypoint="" pygile:latest bash
```

### Jupyter Token Issues
```bash
# Start Jupyter without token
docker run -p 8888:8888 pygile:latest jupyter lab --NotebookApp.token=''
```

##  Package List

**Core Geospatial:**
- GDAL 3.6.2, PROJ 9.1.0, GEOS 3.11.1
- GeoPandas, Rasterio, Shapely, Fiona, PyProj

**Specialized Tools:**
- Geowombat 2.1.22 (raster processing)
- OSMNX (street networks)
- EarthPy (Earth Lab workflows)
- Contextily (basemap tiles)

**Scientific Computing:**
- NumPy 1.24.3, Pandas, SciPy
- Matplotlib, Seaborn, Plotly
- Scikit-learn, XArray

**Complete list:** See [environment.yaml](../environments/linux/environment.yaml)

##  Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Test your changes with Docker
4. Commit your changes: `git commit -m 'Add amazing feature'`
5. Push to the branch: `git push origin feature/amazing-feature`
6. Open a Pull Request

##  License

This project is licensed under the same terms as the main PyGILE repository.

##  Support

- **Issues:** [GitHub Issues](https://github.com/Geoinformatics-Lab/PyGILE/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Geoinformatics-Lab/PyGILE/discussions)
- **Original PyGILE:** [Main Repository](https://github.com/Geoinformatics-Lab/PyGILE)

##  System Requirements

**Minimum:**
- 4GB RAM
- 10GB free disk space
- Docker Desktop

**Recommended:**
- 8GB+ RAM
- 20GB+ free disk space
- Fast internet connection

---
