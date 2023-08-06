# Instalacion de Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Creacion de grafico 
helm create

# Usar repositorio Helm
helm repo add
helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo

# Actualizar cache de repositorio
helm repo update

# Helm repo list
helm repo list

# Buscar graficos en los repositorios agregados
helm search repo

# Buscar un grafico especifico
helm search repo aspnet

# Probar un grafico antes de una version 
helm install --debug --dry-run my-drone-webapp ./drone-webapp

# instalacion desde arhivo local 
helm install my-drone-webapp ./drone-webapp

# instalacion desde archivo local empaquetado
helm install my-drone-webapp ./drone-webapp.tgz

# instalacion desde repositorio
helm install my-release azure-marketplace/aspnet-core

# Consultar versiones instaladas 
helm list

#capturar información del manifiesto relacionada con cada versión
helm get manifest

# Eliminar version de helm
helm delete [chart]

################ Ejercicio: Instalación de un gráfico de Helm ##########

helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo

helm search repo aspnet

#Implementación de un gráfico de Helm
helm install aspnet-webapp azure-marketplace/aspnet-core

# consultar version instalada
helm list

#capturar información del manifiesto relacionada con cada versión
helm get manifest aspnet-webapp

#Eliminar version de helm
helm delete aspnet-webapp

# Compilar grafico con dependencias previamente definidas en el values.yaml
helm dependency build ./app-chart

# Actualizar subgrafico
helm dependency update ./app-chart

# Actualizar version de grafico
helm upgrade my-app ./app-chart

#revisar el historial de implementación de la versión 
helm history my-app

#revertir una versión de Helm
helm rollback my-app 2



####################### Instalación de un gráfico de Helm con valores establecidos #################################

#Ejecute helm install con el parámetro --set para establecer el elemento replicaCount de la plantilla de implementación en cinco réplicas:
helm install --set replicaCount=5 aspnet-webapp azure-marketplace/aspnet-core

# Eliminar el grafico y todas las replicas
helm delete aspnet-webapp


### Revision de estructura de carpetas de un grafico de helm

#Enumere el contenido de la carpeta $HOME/.cache/helm/repository para encontrar el archivo aspnet-core-1.3.18.tgz
ls $HOME/.cache/helm/repository -l

# Inspeccione el gráfico de Helm existente de forma recursiva
cd ~/clouddrive/mslearn-aks/modules/learn-helm-deploy-aks/src
find drone-webapp-chart/ -print

# Ejecute el comando helm dependency build para descargar y actualizar todas las dependencias de gráfico
helm dependency build ./drone-webapp-chart

#Revise los archivos de la carpeta drone-webapp-chart para ver el contenido de la descarga de Helm
find drone-webapp-chart/ -print

# desempaquetar el archivo y mostrar el contenido de la carpeta
gzip -dc ./drone-webapp-chart/charts/common-1.10.0.tgz | tar -xf - -C ./drone-webapp-chart/charts/
find drone-webapp-chart/ -print


############## Implementación del gráfico de Helm ##################

#Implemente el gráfico de Helm drone-webapp mediante el comando 
helm install drone-webapp ./drone-webapp-chart

#Muestre el contenido del archivo create-aks-exports.txt para encontrar la dirección IP del equilibrador de carga
cat ~/clouddrive/mslearn-aks/create-aks-exports.txt

## Actualización de la versión de Helm

# ver cuál es el número de revisión actual de todas las versiones de Helm:
helm list

# ver la información de historial sobre drone-webapp
helm history drone-webapp

# modificar archivos 
code ./drone-webapp-chart/Chart.yaml

# aplicar cambios en el grafico de helm
helm upgrade drone-webapp ./drone-webapp-chart

# ver la información de historial sobre drone-webapp
helm history drone-webapp

# Revierta la versión de Helm
helm rollback drone-webapp 1

# ver la información de historial sobre drone-webapp
helm history drone-webapp

# Reference:
#https://learn.microsoft.com/es-es/training/modules/aks-app-package-management-using-helm/
# https://github.com/MicrosoftDocs/mslearn-aks
# https://helm.sh/docs/helm/helm/
# https://godoc.org/text/template
# https://masterminds.github.io/sprig/
# https://docs.bitnami.com/azure/get-started-charts-marketplace/
# https://dotnet.microsoft.com/apps/aspnet








