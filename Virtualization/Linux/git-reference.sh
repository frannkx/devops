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

#To push the current branch and set the remote as upstream, use

    git push --set-upstream origin main

#To have this happen automatically for branches without a tracking
#upstream, see 'push.autoSetupRemote' in 'git help config'.

# Verifivar configuracion
~/.gitconfig
repo/.git/config
C:\Users\User\.config\git


#Ref: https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/wsl.md#configuring-wsl-without-git-for-windows
git config --global credential.helper "/mnt/c/Users/Francisco\ Paredes/AppData/Local/Programs/Git/mingw64/bin/git-credential-manager.exe" --replace-all

# For Azure DevOps support only
git config --global credential.https://dev.azure.com.useHttpPath true --add