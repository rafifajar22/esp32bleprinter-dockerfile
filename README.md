# esp32bleprinter-Dockerfile
Repository to integrate Dockerfile with docker-hub 
[docker-hub link]
(https://hub.docker.com/r/rafifajar22/esp32devdocker)

## Build Dockerfile
First, before build a Dockerfile, please clone this repo

```bash
git clone https://github.com/rafifajar22/esp32bleprinter-dockerfile
```
after cloning repo, you can build Dockerfile, open your directory where the dockerfile is stored, and run

```bash
docker build -t tagname:version <Dockerfile location>
```
you can edit tagname and version as you need, and you can use "." for dockerfile location if you run in dockerfile directory

## Running Docker Images

check your docker images, to get IMAGE ID

```bash
docker images
```

enable x forwarding on host

```bash
xhost +
```

run docker images with this setting -d = run as daemon, run with X11 forwarding to enable GUI

```bash
docker run -dt --privileged -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix --rm -e DISPLAY=$DISPLAY  <IMAGE ID>
```

pleaes change <IMAGE ID> with your IMAGE ID
  
check running docker, to get CONTAINER ID

```bash
docker ps
```

enter to running docker via exec

```bash
docker exec -it --privileged <CONTAINER ID> /bin/bash
```

pleaes change <CONTAINER ID> with your CONTAINER ID
