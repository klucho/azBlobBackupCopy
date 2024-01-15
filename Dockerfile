FROM ubuntu:latest

# Install fuse, blobfuse2 and update the system
RUN apt update
RUN apt install apt-utils wget rsync -y
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install libfuse3-dev fuse3 -y
RUN apt-get install blobfuse2 encfs -y

# Creates the mount points
RUN mkdir /blobfuseTemp
RUN mkdir /blobfuseMount
RUN mkdir /crypt
RUN mkdir /Origin
RUN mkdir /config

# Exports the mount points for the container.
VOLUME /config
VOLUME /Origin
COPY commands.sh .
RUN chmod a+x /commands.sh

ENTRYPOINT ["/bin/sh", "/commands.sh"]

