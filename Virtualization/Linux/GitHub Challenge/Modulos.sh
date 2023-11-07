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


