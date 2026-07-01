# User Documentation

## Overview

This project deploys a complete WordPress infrastructure using Docker Compose.

The stack contains three services:

- **NGINX**
  - HTTPS only (TLS 1.2/1.3)
  - Public entrypoint

- **WordPress**
  - PHP-FPM
  - Hosts the website

- **MariaDB**
  - Stores the WordPress database

The services communicate through a dedicated Docker network.

## Starting the project

To build and launch the containers, use:

     make

OR

     make up

To stop the containers:

     make down

To restart:

     make restart

To stop the containers + remove the containers and volumes:

     make clean
    
To stop the containers and remove the containers, volumes, and images:

     make fclean

To delete everything and restart:

     make re

For logs infomations:

    All logs:

     make logs

    Wordpress only:

     make wp-logs

    Mariadb only:

     make mariadb-logs

    Nginx only:

     make nginx-logs

To see the runnings containers:

    make info


## Accessing the website

Open your browser and visit:


     https://<login>.42.fr

Example:

     https://mschyns.42.fr

Make sure your `/etc/hosts` file contains:

     127.0.0.1 mschyns.42.fr

(replace 'mschyns' with your own login)


## Accessing the WordPress administration panel

Go to:

     https://<login>.42.fr/wp-admin

Log in using the administrator credentials defined in your `.env` file.

And the files in the folder secrets

---

## Credentials

Credentials are stored using:

- `.env`
- Docker Secrets (Folder secret)

Typical credentials include:

- MariaDB root password
- Database password
- Database name
- WordPress administrator
- WordPress user
- ect...

Passwords should never be hardcoded inside Dockerfiles.

To change the credentials.

Change the .env or files :

- sql_password.txt

- wp_admin_password.txt

- wp_user_password.txt


## Checking the services

Display running containers:

     docker ps
or

     make info


Display logs:

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


## Checking HTTPS

Verify that HTTPS is working:

     https://<login>.42.fr

The connection should use TLS 1.2 or TLS 1.3.


## Persistent data

The project stores persistent data inside Docker volumes.

The data remains available even if containers are recreated.

You can see them in the folders:

     /home/<login>/data/wordpress
and

     /home/<login>/data/mariadb
