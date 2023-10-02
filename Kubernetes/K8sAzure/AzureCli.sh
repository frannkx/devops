
az login 
az login --tenant TENANT_ID
az account set --subscription 6a8f69dd-0e04-4482-be0c-d46a7d513569
az aks get-credentials --resource-group rg-akscostsaving --name akscostsaving-13339

##### Creación de un clúster de Azure Kubernetes Service ####
export RESOURCE_GROUP=rg-contoso-video
export CLUSTER_NAME=aks-contoso-videoÑ
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

    az aks nodepool scale \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $AKS_CLUSTER_NAME \
    --name nodepool1 \
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
#az aks nodepool add \
#    --resource-group resourceGroup \
#    --cluster-name aksCluster \
#    --name spotpool01 \
#    --enable-cluster-autoscaler \
#    --max-count 3 \
#    --min-count 1 \
#    --priority Spot \
#    --eviction-policy Delete \
#    --spot-max-price -1 \
#    --no-wait

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



############ Habilitación del complemento de Azure Policy para AKS ###########

## Habilitación de los proveedores de recursos ContainerService y PolicyInsights

az aks list -o table

az provider register --namespace Microsoft.ContainerService

az provider register --namespace Microsoft.PolicyInsights

az feature register --namespace Microsoft.ContainerService --name AKS-AzurePolicyAutoApprove

az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/AKS-AzurePolicyAutoApprove')].   {Name:name,State:properties.state}"

az provider register -n Microsoft.ContainerService

## Instalación de las extensiones de versión preliminar de la CLI de Azure

az extension add --name aks-preview

az extension show --name aks-preview --query [version]

az extension update --name aks-preview

## Habilitación del complemento de Azure Policy

az aks enable-addons \
    --addons azure-policy \
    --name $AKS_CLUSTER_NAME \
    --resource-group $RESOURCE_GROUP

# comprobar existencia de los pods en namespaces "gatekeeper-system" y "kube-system" (azure-policy-xxx y azure-policy-webhook-xxx)

#comprobar que el complemento más reciente está instalado

az aks show \
 --resource-group $RESOURCE_GROUP\
 --name $AKS_CLUSTER_NAME \
 -o table --query "addonProfiles.azurepolicy"


#Probar solicitud que infrige la politica para evaluar su reaccion
kubectl apply \
--namespace costsavings \
-f test-policy.yaml

###################### Administración de paquetes y aplicaciones con Helm ##################

## Configuración del entorno - Ejecutar el script de implementación

SubscriptionId=$(az account list --query '[0].id' -o tsv)
. <(wget -q -O - https://raw.githubusercontent.com/MicrosoftDocs/mslearn-aks/main/infrastructure/setup/setup.sh ) -s $SubscriptionId -n learn-helm-deploy-aks --use-acr false --install-dot-net false

## Cómo administrar un error inesperado

cd ~ && \
   rm -rf ~/clouddrive/mslearn-aks && \
   az group delete --name learn-helm-deploy-aks-rg --yes


###################### Implementación de un clúster de Azure Kubernetes Service con Azure CNI ######################
az login

az group create --location westeurope --name AKSlearn

# Creacion de la red virtual
az network vnet create \
    --name AKSVirtualNetwork \
    --resource-group AKSlearn \
    --address-prefixes 10.150.0.0/16  \
    --location westeurope

# Creacion de la subnet
az network vnet subnet create \
    --resource-group AKSlearn \
    --vnet-name AKSVirtualNetwork \
    --name AKSSubnet \
    --address-prefixes 10.150.20.0/24

# Creacion de una identidad aministrada
az identity create \
    --name AKSIdentity \
    --resource-group AKSlearn

identityId=$(az identity show \
    --name AKSIdentity \
    --resource-group AKSlearn \
    --query id \
    --output tsv)

# Se almacena el id de la subnet en una variable
subnetId=$(az network vnet subnet list \
    --vnet-name AKSVirtualNetwork \
    --resource-group AKSlearn \
    --query "[?name=='AKSSubnet'].id" \
    --output tsv)

# Creacion del cluster con las variables anteriormente declaradas

az aks create \
    --name AKSCluster \
    --resource-group AKSlearn \
    --location westeurope \
    --network-plugin azure \
    --vnet-subnet-id $subnetId \
    --service-cidr 10.240.0.0/24 \
    --dns-service-ip 10.240.0.10 \
    --generate-ssh-keys \
    --enable-managed-identity \
    --assign-identity $identityId \
    --node-vm-size  Standard_F8s_v2 \
    --node-count 3

# Validar cluster creado

az aks nodepool list \
    --cluster-name AKSCluster \
    --resource-group AKSlearn \
    --output table

# Confirmar uso de direcciones ip
az network vnet subnet list \
    --vnet-name AKSVirtualNetwork \
    --resource-group AKSlearn \
    --query "[].ipConfigurations.length(@)" \
    --output table

# Adicion de nodo al cluster 
az aks scale \
    --name AKSCluster \
    --resource-group AKSlearn \
    --node-count=4

###################### Actualizacion de un cluster AKS ######################

az group create -l westus -n myResourceGroup

az aks get-versions -l westus -o table

KV=1.24.9

az group list -o table 
RG=myResourceGroup

#Crear cluster aks con las variables declaradas
CLUSTERNAME=myakscluster
az aks create -n $CLUSTERNAME -g $RG --kubernetes-version $KV --generate-ssh-keys

# Validar cluster creado
az aks show -n $CLUSTERNAME -g $RG -o table

# Ver actualizaciones disponibles 
az aks get-upgrades -n $CLUSTERNAME -g $RG -o table

# Aplicar actualizacion inmediata de version del cluster AKS (--control-plane-only o --node-image-only)
az aks upgrade -n $CLUSTERNAME -g $RG -k [latest-version]

# Aplicación de actualizaciones de revisiones
az aks upgrade -n $CLUSTERNAME -g $RG --no-wait -k [next-patch-version]
az aks wait -g $RG -n $CLUSTERNAME --update

################ Creación de un clúster de AKS con Azure Policy y el complemento Azure Monitor ################

#registrar los proveedores de recursos y las características en versión preliminar
# Log in first with az login if you're not using Cloud Shell
# Provider register: Register the Azure Policy provider
az provider register --namespace Microsoft.PolicyInsights

# Crear un grupo de recursos
az group create --location eastus --name videogamerg

# Creación de un clúster de AKS con la configuración predeterminada
az aks create --name videogamecluster --resource-group videogamerg

# Habilitación de directivas de Azure para el clúster
az aks enable-addons --addons azure-policy --name videogamecluster --resource-group videogamerg

# Implementación de un pod no compatible en el clúster

az aks get-credentials -n videogamecluster -g videogamerg

# Asignar directivas
https://learn.microsoft.com/es-es/training/modules/aks-governance-azure-policy/5-exercise-assign-policy-to-aks-cluster




