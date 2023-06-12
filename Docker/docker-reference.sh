#!/bin/bash

# Buscar imagenes en Docker
docker search [nombre]

# Descargar imagen 
docker pull [nombre:version]

# Listando Imagenes
docker images

# Correr un contenedor de manera interactiva
docker run -t -i ubuntu /bin/bash

# Correr contenedor mysql de manera desatachada
docker run -d -p 3306:3306 --name mysql-db -e MYSQL_ROOT_PASSWORD=DbR00t mysql

#Correr contenedor con bind de un working directory
docker run -dp 3000:3000 \
    -w /app -v ${PWD}:/app \
    node:12-alpine \
    sh -c "yarn install && yarn run dev"


# Entrar a contenedor corriendo de manera desatachada
docker exec -it mysql-db /bin/bash

# Entrar a contenedor mysql corriendo de manera desatachada
docker exec -it mysql-db mysql -p   

# Buscar id de contenedor
docker ps -a

# Ver logs de un contenedor
docker logs -f [container-id]

# Crear nueva imagen de docker a partir de un contenedor
docker commit [ID container] [nombre]

# Crear imagen a partir de archivo Dockerfile (estando en la misma carpeta)
docker build -t getting-started .

# Eliminar Imagen
docker image rm [nombre]

#publicar imagen en docker hub
docker tag local-image:tagname new-repo:tagname

docker login -u 19583698
docker tag getting-started 19583698/getting-started
docker push 19583698/getting-started
docker push 19583698/getting-started:tagname



docker push new-repo:tagname

# Detener contenedor
docker stop [nombre]

# Encender contenedor apagado
docker start [nombre]

# Eliminar contenedor
docker rm -f [nombre]

# Crear un volumen 
docker volume create [nombre-volumen]

#levantar un contenedor con  montando el volumen en una ruta
docker run -dp 3000:3000 -v [nombre-volumen]:/etc/todos [imagen]

#Ubicar almacenamiento real del volumen 
docker volume inspect todo-db

# Levantar contenedor mysql con persistencia de datos 
docker run -d -p 33060:3306 --name mysql-db3 -e MYSQL_ROOT_PASSWORD=DbR00t --mount src=db-volume,dst=/var/lib/mysql mysql

# Eliminar volumenes temporales creados por docker
docker volume prune

# Listar volumenes creados
docker volume ls

#Uso de montajes de enlace
docker run -dp 80:3000 -w /test -v ${PWD}:/test 19583698/getting-started

## Ambiente Wordpress en docker

#docker pull mysql
docker pull mysql:8.0.23

#docker pull wordpress:5.6.1-php7.4-apache
sudo docker pull wordpress:5.6-php8.0-apache

#docker run --name servidor_mysql -e MYSQL_ROOT_PASSWORD=asdasd -d mysql
docker run --name servidor_wp -p 80:80 --link servidor_mysql:mysql -e MYSQL_ROOT_PASSWORD=p4ssw0rd -d wordpress

#Crear red
docker network create todo-app

#Start a MySQL container and attach it the network
docker run -d \
    --network todo-app --network-alias mysql \
    -v todo-mysql-data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=secret \
    -e MYSQL_DATABASE=todos \
    mysql:5.7

# Iniciar un contenedor estableciendo variables de entorno
docker run -dp 3000:3000 \
  -w /app -v ${PWD}:/app \
  --network todo-app \
  -e MYSQL_HOST=mysql \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD=secret \
  -e MYSQL_DB=todos \
  node:12-alpine \
  sh -c "yarn install && yarn run dev"

#Instalar docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#Comprobar version de docker compose
docker-compose --version

# Creacion de archivo para docker compose
touch docker-compose.yml
#_____ Ejemplo________
#version: "3.7"
#
#services:
#  app:
#    image: node:12-alpine
#    command: sh -c "yarn install && yarn run dev"
#    ports:
#      - 3000:3000
#    working_dir: /app
#    volumes:
#      - ./:/app
#    environment:
#      MYSQL_HOST: mysql
#      MYSQL_USER: root
#      MYSQL_PASSWORD: secret
#      MYSQL_DB: todos
#
#  mysql:
#    image: mysql:5.7
#    volumes:
#      - todo-mysql-data:/var/lib/mysql
#    environment: 
#      MYSQL_ROOT_PASSWORD: secret
#      MYSQL_DATABASE: todos
#
#volumes:
#  todo-mysql-data:
#
#_____________________

#Start up the application stack
docker-compose up -d

#View the logs of the stack creation
docker-compose logs -f app

#Remove the stack
docker-compose down

#Remove the stack whit volumes
docker-compose down --volumes

#view the layers of image creation
docker image history getting-started:latest

#view the layers of image creation not truncated
docker image history --no-trunc getting-started

## Contextos

#Listar contextos
docker context ls

#Inspeccionar el contexto 
docker context inspect default

# Create context
docker context create k8s-test \
  --default-stack-orchestrator=kubernetes \
  --kubernetes config-file=/home/ubuntu/.kube/config \
  --docker host=unix:///var/run/docker.sock

#Ejecutar comandos dentro del contenedor
docker exec -it container-name sh

#referencia https://platzi.com/tutoriales/1432-docker/3268-como-crear-un-contenedor-con-docker-mysql-y-persistir-la-informacion/
# referencia 2 https://clouding.io/hc/es/articles/360010283060-Trabajando-con-im%C3%A1genes-en-Docker   
# referencia 3 https://www.josedomingo.org/pledin/2016/02/enlazando-contenedores-docker/
# referencia 4 https://learn.microsoft.com/es-mx/visualstudio/docker/tutorials/docker-tutorial
# referencia 5 https://docs.docker.com/engine/context/working-with-contexts/
# Azure ACI integration>https://docs.docker.com/cloud/aci-integration/
