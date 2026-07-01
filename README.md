*This activity has been created as part of the 42 curriculum by mschyns*

## Description
The goal of this project was to introduce us to Docker—containers, images, Docker Compose, and so on.

It aimed to teach us how to create services isolated within their own containers and successfully get them to communicate with one another.

## Instructions
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

## Resources
Nginx documentation : https://www.f5.com/fr_fr/glossary/nginx

Mariadb documentation : https://en.wikipedia.org/wiki/MariaDB

Wordpress documentation: https://www.ibm.com/think/topics/wordpress

Docker documentation : https://docs.docker.com/get-started/docker-overview/

Nginx in docker : https://medium.com/@wawerumwaura/nginx-and-docker-configuration-aac7b26210fe

Mariadb in docker : https://www.ionos.com/digitalguide/hosting/technical-matters/mariadb-docker/

Wordpress in docker : https://docs.ovhcloud.com/en/guides/bare-metal-cloud/virtual-private-servers/install-wordpress-docker-on-vps

## Project description

### Virtual Machines vs Docker
To begin with, virtual machines and Docker are both used to isolate environments, but they do so in different ways.

1) Virtual Machines

A virtual machine encompasses an entire system. A complete operating system. Its own drivers and libraries.

Advantages:

    - Very strong isolation. Each VM is independent.

    - Highly secure.

    - Multiple operating systems can run on a single machine.

Disadvantages:

    - Storage-intensive. Each VM has a complete operating system.

    - Uses a lot of RAM.

    - Slow.

2) Docker

All containers share the same kernel—the one belonging to the host machine.

They therefore use the host's drivers.

However, each container has its own libraries, dependencies, and the specific service or application it runs.

All of this operates independently of other containers.

Advantages:

    - Very lightweight

    - Fast

    - Easy to deploy

Disadvantages:

    - Depends on the host machine

    - Weaker isolation compared to VMs

Docker is perfect for microservices.

### Secrets vs Environment Variables

1) Environment Variables

Configuration values

Used to configure an application.

Visible to the process.

Advantages:

    - Simple to use

    - Perfect for non-sensitive data

Disadvantages:
    - Not secure, as they are visible to all services

    - Can be exposed via Git if one is not careful

2) Secrets:

Sensitive data that must be protected

Stored in secure environments.

Controlled permissions

Often encrypted

Advantages:

    - Secure

Disadvantages:

    - Slower if used merely for configuration

### Docker Network vs Host Network
1) Docker Network:

This is a network shared by the containers—a private, local network existing only between them.

Docker creates a mini private network.

It uses an internal private IP address.

2) Host Network

Containers use the host machine's network.

There is no private network between the containers here.

The host machine's network is used, which can lead to port conflicts.

It also presents security issues, as elements might be exposed that were not intended to be.

The host machine's IP address and system ports are used.

### Docker Volumes vs Bind Mounts

Both are used to persist data even after the container is destroyed.

1) Docker Volumes

Storage space generated and managed by Docker itself.

When a volume is requested, Docker creates and uses it.

You can instruct Docker to delete it.

Advantages

    - Easy to manage

    - Secure

Disadvantages
    - Not easily viewable from the host machine

-> Think of it as an internal hard drive managed by Docker.

2) Bind Mounts

In this case, the storage is not managed by Docker; instead, there is a direct link between host files and the container.

Advantages:

    - Transparency

    - Flexibility

Disadvantages:
    
    - Less secure

    - More prone to breakage
