# Docker Commands Guide for PyGILE Project

## 1. How to build and run the PyGILE Docker container

Open Docker Desktop and open PowerShell in your project directory.

Since you have a Dockerfile in the docker folder:

```bash
cd docker
docker build -t pygile-app .
```

To run the container after building:

```bash
docker run --name pygile-container -p 8888:8888 pygile-app
```

## 2. How to push to Docker Hub

First login to Docker Hub:

```bash
docker login
```

Tag your image (already done as iamvuon/pygile_base):

```bash
docker tag pygile-app iamvuon/pygile_base
```

Push to Docker Hub:

```bash
docker push iamvuon/pygile_base
```

## 3. How to pull the existing PyGILE image from Docker Hub and run

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

## 4. How to connect to your PyGILE repo and run Jupyter

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

## 5. How to start the existing PyGILE container

```bash
docker start pygile-container
```

Or for development container:
```bash
docker start pygile-dev-container
```

## 6. How to inspect the PyGILE container

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

## 7. How to manage PyGILE containers and images

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

## Quick Start for PyGILE Development

1. Pull the image: `docker pull iamvuon/pygile_base`
2. Navigate to your PyGILE project directory
3. Run with volume mounting: `docker run --name pygile-dev -p 8888:8888 -v ${PWD}:/workspace/pygile iamvuon/pygile_base`
4. Access Jupyter at: http://localhost:8888