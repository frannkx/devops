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






