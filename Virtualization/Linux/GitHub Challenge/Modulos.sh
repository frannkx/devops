#1# Introducción a Git #

## Introduccion

### Initial configuration
git config --global user.name "user"
git config --global user.email "user@email.com"

### Validate configuration
git config --list

### Repository initialization
git init
### o
git init --initial-branch=main
### o
git init -b main

### View status of repository
git status

### Adding untracking file to repository
git add .

### Commit change to repository
git commit file.txt -m "message of the commit"

### Add and commit chance
git commit -a -m "adding and commit change"
got commit -am "adding and commit change"

### View the history of changes
git log --oneline

### View diferences of changes
git diff

### Create a Git Ignore file
cat << EOF >> .gitignore
*.bak
*~
EOF

### Add changes from all tracked and untracked files
git add -A

### Create and adding empty folder
mkdir folder
touch folder/.git-keep
git add folder

### Save change less commit
git commit --amend --no-edit

### Back recent remove file
git checkout -- file.txt

### Remove file on repository
git remove file.txt

### Recover file deleted on repository
git reset HEAD file.txt

### Recover file content deleted on repository
git reset --hard HEAD^
git checkout -- CCS/site.css

### Revert last commit
git revert --no-edit HEAD

### Revert to a specific commit
git checkout [HASH] .

# Ruta de aprendizaje: Introducción al control de versiones con Git https://learn.microsoft.com/training/paths/intro-to-vc-git/
# Documentación sobre la introducción a GitHub: https://docs.github.com/es/get-started
# Introduction to GitHub: https://learn.microsoft.com/en-us/training/modules/introduction-to-github/
# Every Day: https://git-scm.com/docs/everyday
# Git and GitHub learning resources: https://docs.github.com/en/get-started/quickstart/git-and-github-learning-resources
# Documentation: https://git-scm.com/doc

# Automatización del flujo de trabajo con Acciones de GitHub: https://learn.microsoft.com/es-mx/training/paths/automate-workflow-github-actions/

#2# Procedimientos para crear y modificar un proyecto de Git #

## Procedimientos para crear y modificar un proyecto de Git 

### 
touch index.html
git status
git add .
git status
git commit index.html -m "Create an empty index.html file"
git log
code index.html
<h1>Our Feline Friends</h1>
git status
git commit -a -m "Add a heading to index.html"

### Realización de cambios y seguimiento de estos con Git

<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8'>
    <title>Our Feline Friends</title>
  </head>
  <body>
    <h1>Our Feline Friends</h1>
    <p>Eventually we will put cat pictures here.</p>
    <hr>
  </body>
</html>

git diff

git commit -m "Add HTML boilerplate to index.html" index.html

code .gitignore
*.bak
*~
git add -A
git commit -m "Make small wording change; ignore editor backups"

### Adición de un subdirectorio
mkdir CSS
git status

touch CSS/.git-keep
git add CSS
git status

### Reemplazo de un archivo
rm CSS/.git-keep
cd CSS
code site.css

h1, h2, h3, h4, h5, h6 { font-family: sans-serif; }
body { font-family: serif; }

vi ../index.html
<link rel="stylesheet" href="CSS/site.css">

### Enumeración de las confirmaciones
git log
git log --oneline
git log -n2

### Corrección de errores simples
# modificar confirmacion anterior sin cambiar mensaje (no edit)
git commit --amend --no-edit

# Recuperación de un archivo eliminado: git checkout
git checkout -- <file_name>

# Recuperación de archivos: git reset
git reset HEAD index.html
git checkout -- index.html

# Reversión de una confirmación: git revert (revertir la confirmación anterior.)
git revert
git revert HEAD

#  quitar la confirmación más reciente con el comando
git reset --hard HEAD^

# Práctica de recuperación de un archivo eliminado
rm index.html
ls
git checkout -- index.html

# Práctica de la recuperación de un archivo eliminado: git rm
git rm index.html
git checkout -- index.html (error)
git reset HEAD index.html
git checkout -- index.html

# Reversión de una confirmación
#se cambia el contenido de index

git commit -m "Purposely overwrite the contents of index.html" index.html
git log -n1

git checkout -- index.html
git revert --no-edit HEAD

git log -n1


## Modulo 3 - Colaboración con Git 

# Clonar repositorio 
  git clone

   #SSH (por ejemplo, git@example.com:alice/Cats

# Actualizar cambios desde el origen
git pull

#Creación de solicitudes de incorporación de cambios (git request-pull)

git request-pull -p origin/main .

##Creación de un remoto (git remote) y finalización de la solicitud de incorporación de cambios (git pull)

#configurar el repositorio de otro desarrollador como remoto
git remote

#use ese remoto para las incorporaciones y las solicitudes de incorporación de cambios mediante el comando
git pull

#En segundo plano, git pull es una combinación de dos operaciones más sencillas
git fetch #, que obtiene los cambios
git merge #, que combina esos cambios en el repositorio.

#Ejecutar incorporacion de cambios
git pull remote-alice main

#Colaboración mediante un repositorio compartido, repositorio vacio

mkdir Shared.git
cd Shared.git
git init --bare #Ahora use el siguiente comando para crear un repositorio vacío en el directorio compartido:

git symbolic-ref HEAD refs/heads/main # cambiar la rama HEAD para que apunte a otra rama; en este caso es la rama main

# obtener el contenido de su repositorio en el repositorio compartido.
cd ../Cats
git remote add origin ../Shared.git
git push origin main

#indicar a Git la rama cuyo seguimiento se va a efectuar.
git branch --set-upstream-to origin/main

#Configuración para colaboradores
cd ..
mkdir Bob
cd Bob

#Ahora, clone el repositorio compartido (asegúrese de incluir el punto al final del comando):

#BOB
git clone ../Shared.git .

#Alice
cd ../Alice
git remote set-url origin ../Shared.git

#Inicio de la colaboración

git diff origin -- index.html #ver diferencias de cambios conjuntos en mimsmos archivos

git stash #guardar provisionalmente los cambios de Alice:

#incorporar los cambios con seguridad, después de lo cual puede "sacar" los cambios guardados provisionalmente,
git pull
git stash pop

## Modulo 4 - Edición de código mediante creación de ramas y combinación en Git

#Crear rama
git branch

#cambiar entre ramas 
git checkout

#Combinar con rama principal
git merge


#Ejercicio: Creación de un repositorio vacío compartido
mkdir Shared.git
cd Shared.git

#Ahora, ejecute el comando siguiente para crear un repositorio vacío en el directorio compartido:
git init --bare

#Establezca el nombre de la rama predeterminada del nuevo repositorio. Para realizar este paso, puede cambiar la rama HEAD para que apunte a otra rama; en este caso, la rama main:
git symbolic-ref HEAD refs/heads/main

#Clonación del repositorio compartido para Bob#
cd ..
mkdir Bob

cd Bob
git clone ../Shared.git .
git config user.name Bob
git config user.email bob@contoso.com
git symbolic-ref HEAD refs/heads/main

#Incorporación de archivos base

touch index.html
mkdir Assets
touch Assets/site.css
git add .
git commit -m "Create empty index.html and site.css files"

<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8'>
    <title>Our Feline Friends</title>
    <link rel="stylesheet" href="CSS/site.css">
  </head>
  <body>
    <nav><a href="./index.html">home</a></nav>
    <h1>Our Feline Friends</h1>
    <p>Eventually we will put cat pictures here.</p>
    <footer><hr>Copyright (c) 2021 Contoso Cats</footer>
  </body>
</html>

cd Assets
code site.css

h1, h2, h3, h4, h5, h6 { font-family: sans-serif; }
body { font-family: serif; background-color: #F0FFF8; }
nav, footer { background-color: #C0D8DF; }

cd ..
git add .
git commit -m "Add simple HTML and stylesheet"
git push --set-upstream origin main

#Mensaje
warning: push.default is unset; its implicit value has changed in
Git 2.0 from 'matching' to 'simple'. To squelch this message
and maintain the traditional behavior, use:

  git config --global push.default matching

To squelch this message and adopt the new behavior now, run:

  git config --global push.default simple

When push.default is set to 'matching', git will push local branches
to the remote branches that already exist with the same name.

Since Git 2.0, Git defaults to the more conservative 'simple'
behavior, which only pushes the current branch to the corresponding
remote branch that 'git pull' uses to update the current branch.

See 'git help config' and search for 'push.default' for further information.
(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
'current' instead of 'simple' if you sometimes use older versions of Git)
#

git config --global push.default simple

cd ..
mkdir Alice

cd Alice
git clone ../Shared.git .
git config user.name Alice
git config user.email alice@contoso.com

ls
git status

git branch add-style
git checkout add-style

code site.css

.cat { max-width: 40%; padding: 5 }

git commit -a -m "Add style for cat pictures"

git checkout main
git pull

git merge --ff-only add-style
git push

#Creación de una rama para Bob

cd ../Bob
git checkout -b add-cat

wget https://github.com/MicrosoftDocs/mslearn-branch-merge-git/raw/main/git-resources.zip
unzip git-resources.zip

mv bobcat2-317x240.jpg Assets/bobcat2-317x240.jpg
rm git-resources.zip
rm bombay-cat-180x240.jpg

code index.html

<img src="Assets/bobcat2-317x240.jpg" />

git status

git add .
git commit -a -m "Add picture of Bob's cat"

git checkout main
git pull

git merge add-cat --no-edit
git push

#Sincronización de los repositorios
cd ../Alice
git pull

