#!/bin/bash

# [ Shell config ]
set -e

# [General config file]
ENV_FILE_NAME='venv'

# [ Docker registry settings ]
DOCKER_REGISTRY_NAME='Docker hub'
DOCKER_REGISTRY_URL='https://hub.docker.com/'
DOCKER_REGISTRY_ACCESS_TOKEN='the token'

# [ Registry user credentials]
USER_NAME='the username'
PASSWORD='the password'


# [ Image settings ]
DOCKER_IMAGE='abdoulfataoh/telegram-transactional-chatbot'
DOCKER_IMAGE_TAG='latest'

# [Container settings]
DOCKER_CONTAINER_NAME='telegram_transactional_chatbot'

# [ Registry login ]
docker login

# [ Main ]
output=`docker pull $DOCKER_IMAGE:$DOCKER_IMAGE_TAG`

if [[ $output !=  *"Status: Image is up to date"* ]]
then
    echo "A new version of $DOCKER_IMAGE:$DOCKER_IMAGE_TAG is detected"
    echo "we will try to deploy it"
    echo "(1/2) - remove running image"
    docker rmi -f $DOCKER_IMAGE
    echo "(2/2) - run the new image"
    if [ -f ./$ENV_FILE_NAME ]
    then
        echo "ENV file detected"
        docker run --env-file $ENV_FILE_NAME --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE
    else
        echo "No ENV file detected"
        docker run --name $DOCKER_CONTAINER_NAME $DOCKER_IMAGE
    fi
    echo "$DOCKER_IMAGE new container update done"
else
    echo "$DOCKER_IMAGE:$DOCKER_IMAGE_TAG docker image is up to date"
    echo "Nothing to do"
    echo "Checking in the next periode"
fi