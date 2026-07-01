# Developer Documentation

## Prerequisites

Required software:

- Linux Virtual Machine
- Docker
- Docker Compose
- GNU Make

Verify installation:

     docker --version

     docker compose version

     make --version

## Project structure

```
.
├── Makefile
├── secrets/
├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── mariadb/
│       ├── nginx/
│       └── wordpress/
```

Each service owns:

- Dockerfile
- configuration files
- startup scripts

## Configuration files

All services have their own configuration files.

Nginx has:

    conf/default.conf

Wordpress has:

     tools/setup.sh

Mariadb has:

     conf/50-server.cnf

and

     tools/setup.sh

And they all have a Dockerfile.


## Environment variables

Configuration values are stored inside:

srcs/.env


Examples:

- DOMAIN_NAME=mschyns.42.fr
- SQL_DATABASE=inception
- SQL_USER=mschyns
- WP_USER=test2
- WP_ADMIN_USER=test1


Secrets should not be committed to Git.

Update the .env file with your own data.

A .env_example file is provided with the project.

You can copy it and change the Datas as you want

## Docker Secrets

Sensitive values are store in:

```
secrets/
```

The files:

```
sql_password.txt

wp_admin_password.txt

wp_user_password.txt
```

The secrets are mounted inside containers at runtime.

To setup your own secrets.

You can rename the `.examples` files located in the `secrets` folder.

Rename them to `.txt` and then replace the secrets inside with your own.


## Building the project

     make

or

     make up

or

     docker compose up -d

---

## Stopping the infrastructure

     make down

or

     docker compose down

## Rebuilding everything


     make re

Equivalent to:


     docker compose down

     docker compose up -d --build


## Useful Docker commands

Show running containers:

     docker ps

Show all containers:


     docker ps -a

Show images:


     docker images

Show volumes:

     docker volume ls

Show networks:

     docker network ls


Show logs:

     docker compose logs

or

     make logs

Display one service logs:

     docker compose logs nginx 
or 

     make nginx-logs

     docker compose logs wordpress
or

     make wp-logs

     docker compose logs mariadb
or

     make mariadb-logs



## Data persistence

The project uses two persistent Docker volumes:

- MariaDB database
- WordPress files

The volumes are mounted inside:

```
/home/<login>/data/wordpress
/home/<login>/data/mariad
```

They survive container recreation.

If you want to remove them, you have to do manually.

Docker does not manage bind mounts.

Remove the files insides the 2 folder

## Setup from scratch

You have first to have the prerequisites, see up.

Then :

You have to make the folder:

    /home/<login>/data/wordpress
    /home/<login>/data/mariad

And change de file

    /etc/hosts

By adding line:
    
     127.0.1.1 <login>.42.fr

Then, you can git clone the project.

     git clone git@github.com:ManoSchyns/inception.git

And then, you can use the command see up to build, stop, remove.

To start -> make

And you can go to the website:

     https://<login>.42.fr
    
To see the admin pannel:

     https://<login>.42.fr/wp-admin
