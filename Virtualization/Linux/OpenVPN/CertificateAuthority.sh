https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-a-certificate-authority-ca-on-ubuntu-20-04

#import the certificate request

cd ~/easy-rsa
./easyrsa import-req /tmp/server.req [server]

#sign the request

./easyrsa sign-req server [server]

#copy the files 
scp pki/issued/server.crt sammy@your_vpn_server_ip:/tmp
scp pki/ca.crt sammy@your_vpn_server_ip:/tmp

