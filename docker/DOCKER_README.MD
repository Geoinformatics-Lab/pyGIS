# Docker Commands Guide

## 1. How to build a docker and run

Open docker desktop and open powershell

If you have a Dockerfile:

```
docker build -t IMAGE_NAME .
```

To run this after building:

```
docker run --name CONTAINER_NAME_AS_YOU_WISH -p port:port IMAGE_NAME
```

## 2. How to push to Docker Hub

First login to Docker Hub:

```
docker login
```

Tag your image if needed:

```
docker tag LOCAL_IMAGE_NAME iamvuon/pygile_base
```

Push to Docker Hub:

```
docker push iamvuon/pygile_base
```

## 3. How to pull an existing docker image from docker hub and run a container

Open docker desktop and open terminal

```
docker pull iamvuon/pygile_base
```

```
docker run iamvuon/pygile_base
```

If you want to auto delete when container is stopped:

```
docker run --rm iamvuon/pygile_base
```

To run with a custom name:

```
docker run --name CONTAINER_NAME_AS_YOU_WISH iamvuon/pygile_base
```

## 4. How to connect to a cloned repo and run Jupyter

First git clone:

```
git clone GITHUB_LINK
```

```
cd CLONED-DIRECTORY
```

Complete command with volume mounting:

```
docker run --name CONTAINER_NAME_AS_YOU_WISH -p 8888:8888 -v D:\JUPITER\JAPAN_MAY_JULY\Clone_n_Check\PyGILE-main:/workspace/pygile iamvuon/pygile_base
```

## 5. How to start the already pulled and run container

```
docker start CONTAINER_NAME_AS_YOU_WISH
```

## 6. How to look inside the container

To see what is running:

```
docker ps
```

To get inside the running container:

```
docker exec -it CONTAINER_NAME_AS_YOU_WISH bash
```

To check container details:

```
docker inspect CONTAINER_NAME_AS_YOU_WISH
```

To inspect without running:

```
docker ps -a
```

```
docker start CONTAINER_NAME_AS_YOU_WISH
```

View container logs:

```
docker logs CONTAINER_NAME_AS_YOU_WISH
```

Run interactively:

```
docker run -it iamvuon/pygile_base bash
```

## 7. How to manage containers and images

To see all images:

```
docker images
```

To stop running containers:

```
docker stop CONTAINER_NAME_AS_YOU_WISH
```

To remove containers:

```
docker rm CONTAINER_NAME_AS_YOU_WISH
```

To remove images:

```
docker rmi IMAGE_NAME
```