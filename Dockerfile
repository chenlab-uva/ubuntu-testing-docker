FROM ubuntu:18.04

RUN apt update && apt install -y gnupg ca-certificates
RUN apt update && apt install -y build-essential zlib1g-dev sudo wget git python3 && rm -rf /var/lib/apt/lists/*

# Set up users
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers
ARG userId
ARG groupId
RUN mkdir -p /home/developer && \
    echo "developer:x:$userId:$groupId:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:$userId:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown $userId:$groupId -R /home/developer

USER root
ENV HOME /home/developer
WORKDIR /home/developer
RUN git clone https://github.com/chenlab-uva/king_testing.git testing
WORKDIR /home/developer/testing
RUN  python3 test.py -v