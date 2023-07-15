

##### Creación de un clúster de Azure Kubernetes Service ####
export RESOURCE_GROUP=rg-contoso-video
export CLUSTER_NAME=aks-contoso-video
export LOCATION=<myLocation> eastus
export LOCATION=eastus

#Ejecute el comando az group create para crear un grupo de recursos. Implemente todos los recursos en este nuevo grupo de recursos.
az group create --name=$RESOURCE_GROUP --location=$LOCATION

# Ejecute el comando az aks create para crear un clúster de AKS.
az aks create \
    --resource-group $RESOURCE_GROUP \
    --name $CLUSTER_NAME \
    --node-count 2 \
    --enable-addons http_application_routing \
    --generate-ssh-keys \
    --node-vm-size Standard_B2s \
    --network-plugin azure

# Ejecute el comando az aks nodepool add para agregar otro grupo de nodos que use el sistema operativo Linux predeterminado.

az aks nodepool add \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    --name userpool \
    --node-count 2 \
    --node-vm-size Standard_B2s

# Vincular al kubectl
az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP

####################################################



#### Configuración de varios nodos y habilitación de la escala a cero mediante AKS ####

#Este es un ejemplo del comando az aks node pool add que puede usar para crear el grupo de nodos. Observe el parámetro --node-vm-size, que especifica el tamaño de máquina virtual basada en GPU Standard_NC6 para los nodos del grupo.

az aks nodepool add \
    --resource-group resourceGroup \
    --cluster-name aksCluster \
    --name gpunodepool \
    --node-count 1 \
    --node-vm-size Standard_NC6 \
    --no-wait

# Cuando el grupo esté listo, puede usar el comando az aks nodepool scale para escalar el grupo de nodos a cero nodos. Observe que el parámetro --node-count está establecido en cero. Este es un ejemplo del comando:

az aks nodepool scale \
    --resource-group resourceGroup \
    --cluster-name aksCluster \
    --name gpunodepool \
    --node-count 0

####################################################

############# AKS Cluster Scale to 0 #######################################

REGION_NAME=eastus
RESOURCE_GROUP=rg-akscostsaving
AKS_CLUSTER_NAME=akscostsaving-$RANDOM

echo $AKS_CLUSTER_NAME

az group create \
    --name $RESOURCE_GROUP \
    --location $REGION_NAME

VERSION=$(az aks get-versions \
    --location $REGION_NAME \
    --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
    --output tsv)

az aks create \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME \
    --location $REGION_NAME \
    --kubernetes-version $VERSION \
    --node-count 2 \
    --load-balancer-sku standard \
    --vm-set-type VirtualMachineScaleSets \
    --generate-ssh-keys

az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME --output table

az aks nodepool add \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $AKS_CLUSTER_NAME \
    --name batchprocpl \
    --node-count 2

az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME --output table

# Ejecute el comando az aks nodepool scale y use el parámetro --node-count para establecer el valor del recuento de nodos en 0
az aks nodepool scale \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $AKS_CLUSTER_NAME \
    --name batchprocpl \
    --node-count 0

az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME



############ AKS con el escalador automático de clúster###########

#registrar la característica spotpoolpreview
az feature register --namespace "Microsoft.ContainerService" --name "spotpoolpreview"

# comprobar el estado del registro 
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/spotpoolpreview')].{Name:name,State:properties.state}"

#propagar el nuevo registro
az provider register --namespace Microsoft.ContainerService

# Instalación de la extensión aks-preview de la CLI
az extension add --name aks-preview

# Compruebe cuál es la versión instalada de la extensión >0.4.53
az extension show --name aks-preview --query [version]

# Si ya ha instalado la extensión y necesita actualizarla a una versión más reciente
az extension update --name aks-preview


## Adición de un grupo de nodos de acceso puntual a un clúster de AKS ##
az aks nodepool add \
    --resource-group resourceGroup \
    --cluster-name aksCluster \
    --name spotpool01 \
    --enable-cluster-autoscaler \
    --max-count 3 \
    --min-count 1 \
    --priority Spot \
    --eviction-policy Delete \
    --spot-max-price -1 \
    --no-wait

--
az aks nodepool add \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $AKS_CLUSTER_NAME \
    --name batchprocpl2 \
    --enable-cluster-autoscaler \
    --max-count 3 \
    --min-count 1 \
    --priority Spot \
    --eviction-policy Delete \
    --spot-max-price -1 \
    --node-vm-size Standard_DS2_v2 \
    --no-wait

#mostrar los detalles del nuevo grupo de nodos de acceso puntual para el servicio de procesamiento por lotes
az aks nodepool show \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $AKS_CLUSTER_NAME \
    --name batchprocpl2



