# auto-deploy-docker-image
A quick bash script to deploy/run  always some latest docker container

# How to use

1. clone the project

```bash
    git clone git@github.com:abdoulfataoh/auto-deploy-docker-image.git
    cd auto-deploy-docker-image
```

2. set execution permission to ``deploy.sh``

```bash
    chmod u+x deploy.sh
```

3. set these variable values fron ``deploy.sh``

```bash
    ENV_FILE_NAME='venv'

    # [ Docker registry settings ]
    DOCKER_REGISTRY_NAME='Docker Hub'
    DOCKER_REGISTRY_URL='https://hub.docker.com/'
    DOCKER_REGISTRY_USERNAME='username'
    DOCKER_REGISTRY_ACCESS_TOKEN='the access token'


    # [ Image settings ]
    DOCKER_IMAGE='docker image '
    DOCKER_IMAGE_TAG='tag'

    # [Container settings]
    DOCKER_CONTAINER_NAME='docker_image'

```

4. set the container env variables (if exists) from ``venv``

```
    VAR1='toto'
    VAR2='tata'
```

5. execute the script periodically (ex: every 2 minutes) with ``cron``

- type this command
```bash
    crontab -e
```

- and write this line at the end of file
```bash
*/2 * * * * path_to_script_folder/deploy.sh

```


