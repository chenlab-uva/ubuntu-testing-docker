# ubuntu-testing-docker

BUILD: ``sudo docker build --no-cache --build-arg userId=`id -u` --build-arg groupId=`id -g` -t ubuntuking .``      .

RUN: `sudo docker run -ti ubuntuking`.