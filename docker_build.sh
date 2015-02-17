#!/bin/bash

set -e
cd $WORKSPACE
git checkout $VERSION
VERSION_NAME=${VERSION#release\/}

sudo docker build -t musashi/elasticsearch:$VERSION_NAME .
sudo docker tag musashi/elasticsearch:$VERSION_NAME $DOCKER_BASE_URL/musashi/elasticsearch:${VERSION_NAME}_${BUILD_NUMBER}
sudo docker push $DOCKER_BASE_URL/musashi/elasticsearch:${VERSION_NAME}_${BUILD_NUMBER}