#!/bin/bash

# [ Shell config ]
set -e

# [General config file]
ENV_FILE_NAME='venv'

# [ Docker registry settings ]
DOCKER_REGISTRY_NAME='Docker hub'
DOCKER_REGISTRY_URL='https://hub.docker.com/'
DOCKER_REGISTRY_USERNAME='username'
DOCKER_REGISTRY_ACCESS_TOKEN='the access token'


# [ Image settings ]
DOCKER_IMAGE='abdoulfataoh/telegram-transactional-chatbot'
DOCKER_IMAGE_TAG='latest'

# [Container settings]
DOCKER_CONTAINER_NAME='telegram_transactional_chatbot'

# [ Registry login ]
docker login -u $DOCKER_REGISTRY_USERNAME -p $DOCKER_REGISTRY_ACCESS_TOKEN

# [ Main ]
output=`docker pull $DOCKER_IMAGE:$DOCKER_IMAGE_TAG`
env_file_path=$( dirname -- "$( readlink -f -- "$0"; )"; )/$ENV_FILE_NAME

if [[ $output !=  *"Status: Image is up to date"* ]]
then
    echo "A new version of $DOCKER_IMAGE:$DOCKER_IMAGE_TAG is detected"
    echo "we will try to deploy it"
    echo "(1/2) - remove running image"
    docker rm -f $DOCKER_CONTAINER_NAME
    echo "(2/2) - run the new image"
    if [ -f $env_file_path ]
    then
        echo "ENV file detected at $env_file_path"
        docker run -d --env-file $env_file_path --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE
    else
        echo "No ENV file detected"
        docker run -d --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE
    fi
    echo "$DOCKER_IMAGE new container update done"
else
    echo "$DOCKER_IMAGE:$DOCKER_IMAGE_TAG docker image is up to date"
    echo "Nothing to do"
    echo "Checking in the next periode"
fi
