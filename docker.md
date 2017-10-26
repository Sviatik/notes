## Docker notes
    docker run -d --privileged myimage	# You can use openconnect
    docker save busybox > busybox.tar	# create image
    docker commit 20ac8921456f micros_test:tag1
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker build -t centos/micros-cli .
    docker rmi $(docker images -a -q)
