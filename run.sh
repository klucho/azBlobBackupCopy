#!/bin/bash
#

# Builds the docker container.
#
docker build -t blobbackup:latest .

# Runs the docker cantainer.
#
docker run -v <path to cantainer configfiles>:/Config -v <path to backup>:/Origin --privileged  blobbackup:latest

