
#### Open VPN Server Instalation ####

# Instal applications
sudo apt update
sudo apt install openvpn easy-rsa

# create directory to OpenVPN
mkdir ~/easy-rsa

#Symlink from easyrsa
ln -s /usr/share/easy-rsa/* ~/easy-rsa/

#Adjust owner and access
sudo chown sammy ~/easy-rsa
chmod 700 ~/easy-rsa

# Build PKI directory
cd ~/easy-rsa

echo '
set_var EASYRSA_ALGO "ec"
set_var EASYRSA_DIGEST "sha512"' >> vars

./easyrsa init-pki


# Create OpenVPN server certificate request and private key
cd ~/easy-rsa

./easyrsa gen-req [server] nopass

sudo cp /home/sammy/easy-rsa/pki/private/server.key /etc/openvpn/server/


# Sign the server certificate request
scp /home/sammy/easy-rsa/pki/reqs/server.req sammy@your_ca_server_ip:/tmp

#copy the sign files 
sudo cp /tmp/{server.crt,ca.crt} /etc/openvpn/server

#generate pre-shared secret key
cd ~/easy-rsa
openvpn --genkey --secret ta.key

#copy the result 
sudo cp ta.key /etc/openvpn/server


