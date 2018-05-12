This repository contains the Docker assets needed to build a custom mediawiki installation from the [official mediawiki image](https://hub.docker.com/_/mediawiki/) and to orchestrate a deployment with a MySQL container.  It is used to build a wiki for a research group I participate in and is linked to Docker Hub to auto-build the [stuartm2/minewiki](https://hub.docker.com/r/stuartm2/minewiki/) image.  I've made it public to provide an example of how you might approach building a custom Wiki container using the official image.

The build installs a PHP extension, mediawiki extensions (via both composer and manual download/extract) and customises the environment.  It depends on a number of environment variables to be set, which can be defined in a .env file (an example is provided).

## Instructions

While not intended as an off-the-shelf working deployment, it is trivial to get a wiki running using this repository:

    git clone git@github.com:stuartm2/minewiki.git
    cd minewiki

You'll need to provide appropriate environment variables (optionally edit the file with your own settings):

    cp example.env .env

Build and bring-up the containers and populate the database with initial data.

    docker-compose build
    docker-compose -f docker-compose.yml -f docker-compose.initialise.yml up -d

An existing database can be imported on first-launch by adding your mysqldump output file to the mysql_data directory.

Subsequent runs can be brought-up with:

    docker-compose up -d

If it worked as intended, you should be able to access the Wiki at [http://localhost:8080](http://localhost:8080) and log in with admin:p4ssw0rd
