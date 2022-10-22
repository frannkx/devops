## Configuracion de GIT

git config --global user.name "frannkx"
git config --global user.email "frannkx@gmail.com"

git config --list

# crear llave SSH  
#https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
#https://qastack.mx/ubuntu/363207/what-is-the-difference-between-the-rsa-dsa-and-ecdsa-keys-that-ssh-uses
#https://git-scm.com/book/es/v2/Fundamentos-de-Git-Trabajar-con-Remotos

ssh-keygen -t rsa -b 4096 -C frannkx@gmail.com

eval "$(ssh-agent -s)"

#agregar llave privada al servidor ssh
ssh-add ~/.ssh/id_rsa

#agregar llave publica a github

sudo apt install xclip

#copiar al portapapaeles
xclip -selection clipboard < ~/.ssh/id_rsa.pub

#pegar contenido en administracion de llaves en github

a;adir origen remoto
git remote add origin urlxxx.git

git remote -v

git branch -M main
git push -u origin main


