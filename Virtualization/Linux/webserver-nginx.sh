##---------Instalacion servidor web Nginx en Ubuntu------------

#Busqueda de paquete nginx
sudo apt search "nginx$"

sudo apt update && sudo apt install nginx

#Archivo de confiuracion de nginx
/etc/nginx/nginx.conf

#ruta raiz de sitio web
/var/www/html

#configuracion de sitio por defecto 
/etc/nginx/sites-enabled/default #copiarlo y crear nuevo archivo con el nombre del dominio del sitio luego crear enlace simbolico desde ../sites-available

#validacion de funcionamiento de nginx
sudo systemctl status nginx

sudo netstat -tulpn

curl -i localhost

cd /etc/nginx/
grep -i include\*.conf nginx.conf
cat > conf.d/stub_status.conf
##stub_status.conf##
server{
        listen 127.0.0.1:80;
        server_name 127.0.0.1;
        location /nginx_status {
                stub_status on;
                allow 127.0.0.1;
                deny all;
        }
}
###

kill -HUP `cat /var/run/nginx.pid`

systemctl restart nginx && sustemctl enable nginx 

#------ Instalacion de Nginx Amplify ------

#ir al portal de nginx amplify y registrarse https://amplify.nginx.com

sudo apt install python2.7

curl -L -O https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh
# o
wget https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh

sudo API_KEY='xxx' sh ./install.sh

service amplify-agent start

##https://amplify.nginx.com/docs/guide-metrics-and-metadata.html#additional-nginx-metrics
##http://nginx.org/en/docs/varindex.html