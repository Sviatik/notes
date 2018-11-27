## Docker notes
    docker run -d --privileged myimage	# You can use openconnect
    docker save busybox > busybox.tar	# create image
    docker commit 20ac8921456f micros_test:tag1
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker build -t centos/micros-cli .
    docker rmi $(docker images -a -q)




## Docker-compose
```
version: '2'

services:				# Block with services
  web:					# name service
    build: . 			# it means that Docker file for web service exist on current directory
    ports:				
     - "5000:5000"		# forward port "local":"In container"
    volumes:
     - .:/code 			# Attach volume "local":"In container"
  redis:				
    image: redis		# That image name will download from 
```