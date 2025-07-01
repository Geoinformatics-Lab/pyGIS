# Docker Commands Guide for PyGILE Project

## Quick Start for PyGILE Development

1. Pull the image: `docker pull iamvuon/pygile_base`
2. Navigate to your PyGILE project directory
3. Run with volume mounting: `docker run --name pygile-dev -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base`
4. Access Jupyter at: http://localhost:8888

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

First clone your PyGILE repository:

```bash
git clone https://github.com/your-username/PyGILE.git
cd PyGILE
```

Complete command with volume mounting for PyGILE development:

```bash
docker run --name pygile-dev-container -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base
```

For Windows PowerShell:
```bash
docker run --name pygile-dev-container -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base
```

For Windows Command Prompt:
```bash
docker run --name pygile-dev-container -p 8888:8888 -v %cd%:/workspace/pygile iamvuon/pygile_base
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

