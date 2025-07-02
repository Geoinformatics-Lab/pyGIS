# Docker Commands Guide for PyGILE Project

## Quick Start for PyGILE Development

1. Pull the image: `docker pull iamvuon/pygile_base`
2. Navigate to your PyGILE project directory
3. Run with volume mounting: `docker run --name pygile-dev -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base`
4. Access Jupyter at: http://localhost:8888

## Platform-Specific Instructions

### **Windows**

```bash
# Pull the image
docker pull iamvuon/pygile_base

# Run with volume mounting (PowerShell)
docker run --name pygile-dev-container -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base

# Run with volume mounting (Command Prompt)
docker run --name pygile-dev-container -p 8888:8888 -v %cd%:/workspace/pygile iamvuon/pygile_base
```

### **Linux**

```bash
# Pull the image (try ARM64 first, fallback to amd64 if needed)
docker pull --platform linux/arm64 iamvuon/pygile_base || docker pull --platform linux/amd64 iamvuon/pygile_base

# Run with volume mounting
docker run --name pygile-dev-container -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base
```

### **macOS (Apple Silicon M1/M2/M3)**

**IMPORTANT**: Always specify platform explicitly to avoid architecture issues.

```bash
# Pull with explicit platform
docker pull --platform linux/amd64 iamvuon/pygile_base

# Run with explicit platform to avoid compatibility issues
docker run --platform linux/amd64 --name pygile-dev-container -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base
```

**Required Setup for macOS**:
1. Open Docker Desktop Settings
2. Go to "Features in Development" 
3. Check "Use Rosetta for x86/amd64 emulation on Apple Silicon"
4. Apply & Restart

## How to build and run the PyGILE Docker container?

Open Docker Desktop and open PowerShell in your project directory.

Since you have a Dockerfile in the docker folder:

```bash
cd D:\JUPITER\JAPAN_MAY_JULY\GITHUB\pyGILE-main\docker [Adjust path based on your cloned folder location]
docker build -t pygile-app .
```

To run the container after building:

```bash
docker run --name pygile-container -p 8888:8888 pygile-app
```

OR; IF YOU WISH TO PULL AND RUN WITHOUT BUILDING

## How to pull the existing PyGILE image from Docker Hub and run?

Open Docker Desktop and open terminal:

```bash
docker pull iamvuon/pygile_base
```

Run the container:

```bash
docker run iamvuon/pygile_base
```

If you want to auto-delete when container stops:

```bash
docker run --rm iamvuon/pygile_base
```

To run with the standard PyGILE container name:

```bash
docker run --name pygile-container iamvuon/pygile_base
```

## How to connect to your PyGILE repo and run Jupyter?

## Installing Git

### Windows
1. Download Git from [git-scm.com](https://git-scm.com/download/win)
2. Run the installer and follow the setup wizard
3. Choose "Git from the command line and also from 3rd-party software"
4. Use the default options for other settings

### macOS
```bash
# Using Homebrew (recommended)
brew install git

# Or using Xcode Command Line Tools
xcode-select --install
```

### Linux

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install git
```

Once Git is installed, clone this repository:

```bash
git clone https://github.com/Geoinformatics-Lab/PyGILE.git
cd PyGILE-main
```

## How to start the existing PyGILE container?

```bash
docker start pygile-container
```

Or for development container:
```bash
docker start pygile-dev-container
```

## How to inspect the PyGILE container?

To see what containers are running:

```bash
docker ps
```

To get inside the running PyGILE container:

```bash
docker exec -it pygile-container bash
```

Or for development container:
```bash
docker exec -it pygile-dev-container bash
```

To check PyGILE container details:

```bash
docker inspect pygile-container
```

To see all containers (including stopped):

```bash
docker ps -a
```

View PyGILE container logs:

```bash
docker logs pygile-container
```

Run PyGILE interactively:

```bash
docker run -it iamvuon/pygile_base bash
```

## How to manage PyGILE containers and images?

To see all images:

```bash
docker images
```

To stop the PyGILE container:

```bash
docker stop pygile-container
```

To remove the PyGILE container:

```bash
docker rm pygile-container
```

To remove the PyGILE image:

```bash
docker rmi pygile-app
# or
docker rmi iamvuon/pygile_base
```