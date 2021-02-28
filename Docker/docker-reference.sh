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

# Entrar a contenedor corriendo de manera desatachada
docker exec -it mysql-db /bin/bash

# Entrar a contenedor mysql corriendo de manera desatachada
docker exec -it mysql-db mysql -p   

# Buscar id de contenedor
docker ps -a

# Crear nueva imagen de docker
docker commit [ID container] [nombre]

# Eliminar Imagen
docker image rm [nombre]

#publicar imagen en docker hub
docker tag local-image:tagname new-repo:tagname

docker login -u 19583698
docker tag getting-started 19583698/getting-started
docker push 19583698/getting-started



docker push new-repo:tagname

# Detener contenedor
docker stop [nombre]

# Encender contenedor apagado
docker start [nombre]

# Eliminar contenedor
docker rm -f [nombre]

# Crear un volumen 
docker volume create [nombre-volumen]

# Levantar contenedor mysql con persistencia de datos 
docker run -d -p 33060:3306 --name mysql-db3 -e MYSQL_ROOT_PASSWORD=DbR00t --mount src=db-volume,dst=/var/lib/mysql mysql

# Eliminar volumenes temporales creados por docker
docker volume prune

# Listar volumenes creados
docker volume ls

#referencia https://platzi.com/tutoriales/1432-docker/3268-como-crear-un-contenedor-con-docker-mysql-y-persistir-la-informacion/
# referencia 2 https://clouding.io/hc/es/articles/360010283060-Trabajando-con-im%C3%A1genes-en-Docker   
# referencia 3 https://www.josedomingo.org/pledin/2016/02/enlazando-contenedores-docker/


## Ambiente Wordpress en docker

#docker pull mysql
docker pull mysql:8.0.23

#docker pull wordpress:5.6.1-php7.4-apache
sudo docker pull wordpress:5.6-php8.0-apache

#docker run --name servidor_mysql -e MYSQL_ROOT_PASSWORD=asdasd -d mysql
docker run --name servidor_wp -p 80:80 --link servidor_mysql:mysql -e MYSQL_ROOT_PASSWORD=p4ssw0rd -d wordpress