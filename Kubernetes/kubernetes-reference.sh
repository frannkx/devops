#Lab instaling minikube on Linux

##Create a cluster

#view veresion of minikube
minikube version

#start cluster
minikube start

#To interact with Kubernetes during this bootcamp we’ll use the command line interface, kubectl. 

#to check the version of kubectl
kubectl version

    #client version = kubectl version
    #server version = kubernetes version

#view the cluster details
kubectl cluster-info

#To further debug and diagnose cluster problems
kubectl cluster-info dump

#view nodes in the cluster
kubectl get nodes
kubectl get nodes -o wide

#ver servicios que estan corriendo
sudo kubectl get services -o wide
sudo kubectl get services -o wide --all-namespaces

#Open the Kubernetes dashboard in a browser:
minikube dashboard

minikube dashboard --url

##Using kubectl to create a Deployment

#reate a Deployment that manages a Pod. The Pod runs a Container based on the provided Docker image.
#kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1

#View the deployment
kubectl get deployments

#view the pod
kubectl get pods

#View cluster events:
kubectl get events

#View the kubectl configuration
kubectl config view

#the kubectl command can create a proxy that will forward communications into the cluster-wide, private network.
echo -e "\n\n\n\e[92mStarting Proxy. After starting it will not output a response. Please click the first Terminal Tab\n"; 
kubectl proxy

#You can see all those APIs hosted through the proxy endpoint. For example, we can query the version directly through the API using the curl command
curl http://localhost:8001/version

#The API server will automatically create an endpoint for each pod, based on the pod name, that is also accessible through the proxy.
#First we need to get the Pod name, and we'll store in the environment variable POD_NAME:
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

##Create a Service

#Expose the Pod to the public internet using the kubectl expose command:
kubectl expose deployment hello-node --type=LoadBalancer --port=8080

#View the Service you just created:
kubectl get services

minikube service hello-node

##Enable addons
#The minikube tool includes a set of built-in addons that can be enabled, disabled and opened in the local Kubernetes environment.

#list the currently supported addons:
minikube addons list

#Enable an addon, for example, metrics-server
minikube addons enable metrics-server

#View the Pod and Service you just created
kubectl get pod,svc -n kube-system

#Disable metrics-server
minikube addons disable metrics-server

##Clean up
kubectl delete service hello-node
kubectl delete deployment hello-node
minikube stop
minikube delete


#Troubleshooting with kubectl
kubectl get - list resources
kubectl describe - show detailed information about a resource
kubectl logs - print the logs from a container in a pod
kubectl exec - execute a command on a container in a pod

#Look for existing Pods
kubectl get pods

#view what containers are inside that Pod 
kubectl describe pods

 Click on the command below to automatically open a new terminal and run the proxy
echo -e "\n\n\n\e[92mStarting Proxy. After starting it will not output a response. Please click the first Terminal Tab\n"; kubectl proxy


export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/

#View the container logs
kubectl logs $POD_NAME

#Executing command on the container 
kubectl exec $POD_NAME env

#start a bash session in the Pod’s container
kubectl exec -ti $POD_NAME bash

view
cat server.js

curl localhost:8080

#Expose your app
kubectl get pods

kubectl get services

kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080

kubectl get services

kubectl describe services/kubernetes-bootcamp

export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT

curl $(minikube ip):$NODE_PORT

#Using labels
kubectl describe deployment

kubectl get pods -l run=kubernetes-bootcamp

kubectl get services -l run=kubernetes-bootcamp

export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

#To apply a new label we use the label command followed by the object type, object name and the new label
kubectl label pod $POD_NAME app=v1

#check it with the describe pod command
kubectl describe pods $POD_NAME

#we can query now the list of pods using the new label
kubectl get pods -l app=v1

##Deleting a service


kubectl delete service -l run=kubernetes-bootcamp

#Confirm that the service is gone:
kubectl get services

#confirms that our Service was removed
curl $(minikube ip):$NODE_PORT

#This proves that the app is not reachable anymore from outside of the cluster. You can confirm that the app is still running with a curl inside the pod:
kubectl exec -ti $POD_NAME curl localhost:8080

###################################### Kubectl ########################################################

#Creating a Cluster

#Deploy an app
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
kubectl get services

##Exploring Your App
kubectl get pods
kubectl describe pods

echo -e "\n\n\n\e[92mStarting Proxy. After starting it will not output a response. Please click the first Terminal Tab\n"; kubectl proxy
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/

kubectl logs $POD_NAME

#Editar deployment 
kubectl edit ingress -n namespace nombre-ingress

#Executing command on the container
kubectl exec $POD_NAME env
kubectl exec -ti $POD_NAME bash

##Using a Service to Expose Your App
#ClusterIP (default) - Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster.
#NodePort - Exposes the Service on the same port of each selected Node in the cluster using NAT. Makes a Service accessible from outside the cluster using <NodeIP>:<NodePort>. Superset of ClusterIP.
#LoadBalancer - Creates an external load balancer in the current cloud (if supported) and assigns a fixed, external IP to the Service. Superset of NodePort.
#ExternalName - Exposes the Service using an arbitrary name (specified by externalName in the spec) by returning a CNAME record with the name. No proxy is used. This type requires v1.7 or higher of kube-dns.
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080

export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
kubectl label pod $POD_NAME app=v1


=======
#Lab instaling minikube on Linux

##Create a cluster

#view veresion of minikube
minikube version

#start cluster
minikube start

#To interact with Kubernetes during this bootcamp we’ll use the command line interface, kubectl. 

#to check the version of kubectl
kubectl version

    #client version = kubectl version
    #server version = kubernetes version

#view the cluster details
kubectl cluster-info

#view nodes in the cluster
kubectl get nodes

#Open the Kubernetes dashboard in a browser:
minikube dashboard


minikube dashboard --url

##Using kubectl to create a Deployment

#reate a Deployment that manages a Pod. The Pod runs a Container based on the provided Docker image.
#kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1

#View the deployment
kubectl get deployments

#view the pod
kubectl get pods

#View cluster events:
kubectl get events

#View the kubectl configuration
kubectl config view

#the kubectl command can create a proxy that will forward communications into the cluster-wide, private network.
echo -e "\n\n\n\e[92mStarting Proxy. After starting it will not output a response. Please click the first Terminal Tab\n"; 
kubectl proxy

#You can see all those APIs hosted through the proxy endpoint. For example, we can query the version directly through the API using the curl command
curl http://localhost:8001/version

#The API server will automatically create an endpoint for each pod, based on the pod name, that is also accessible through the proxy.
#First we need to get the Pod name, and we'll store in the environment variable POD_NAME:
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

##Create a Service

#Expose the Pod to the public internet using the kubectl expose command:
kubectl expose deployment hello-node --type=LoadBalancer --port=8080

#View the Service you just created:
kubectl get services

minikube service hello-node

##Enable addons
#The minikube tool includes a set of built-in addons that can be enabled, disabled and opened in the local Kubernetes environment.

#list the currently supported addons:
minikube addons list

#Enable an addon, for example, metrics-server
minikube addons enable metrics-server

#View the Pod and Service you just created
kubectl get pod,svc -n kube-system

#Disable metrics-server
minikube addons disable metrics-server

##Clean up
kubectl delete service hello-node
kubectl delete deployment hello-node
minikube stop
minikube delete


#Troubleshooting with kubectl
kubectl get - list resources
kubectl describe - show detailed information about a resource
kubectl logs - print the logs from a container in a pod
kubectl exec - execute a command on a container in a pod

#Look for existing Pods
kubectl get pods

#view what containers are inside that Pod 
kubectl describe pods

 Click on the command below to automatically open a new terminal and run the proxy
echo -e "\n\n\n\e[92mStarting Proxy. After starting it will not output a response. Please click the first Terminal Tab\n"; kubectl proxy


export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/

#View the container logs
kubectl logs $POD_NAME

#Executing command on the container 
kubectl exec $POD_NAME env

#start a bash session in the Pod’s container
kubectl exec -ti $POD_NAME bash

view
cat server.js

curl localhost:8080

#Expose your app
kubectl get pods

kubectl get services

kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080

kubectl get services

kubectl describe services/kubernetes-bootcamp

export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT

curl $(minikube ip):$NODE_PORT

#Using labels
kubectl describe deployment

kubectl get pods -l run=kubernetes-bootcamp

kubectl get services -l run=kubernetes-bootcamp

export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

#To apply a new label we use the label command followed by the object type, object name and the new label
kubectl label pod $POD_NAME app=v1

#check it with the describe pod command
kubectl describe pods $POD_NAME

#we can query now the list of pods using the new label
kubectl get pods -l app=v1

##Deleting a service


kubectl delete service -l run=kubernetes-bootcamp

#Confirm that the service is gone:
kubectl get services

#confirms that our Service was removed
curl $(minikube ip):$NODE_PORT

#This proves that the app is not reachable anymore from outside of the cluster. You can confirm that the app is still running with a curl inside the pod:
kubectl exec -ti $POD_NAME curl localhost:8080

###################################### Kubectl ########################################################

#Creating a Cluster

#Deploy an app
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
kubectl get services

##Exploring Your App
kubectl get pods
kubectl describe pods

echo -e "\n\n\n\e[92mStarting Proxy. After starting it will not output a response. Please click the first Terminal Tab\n"; kubectl proxy
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/

kubectl logs $POD_NAME

#Executing command on the container
kubectl exec $POD_NAME env
kubectl exec -ti $POD_NAME bash

##Using a Service to Expose Your App
#ClusterIP (default) - Exposes the Service on an internal IP in the cluster. This type makes the Service only reachable from within the cluster.
#NodePort - Exposes the Service on the same port of each selected Node in the cluster using NAT. Makes a Service accessible from outside the cluster using <NodeIP>:<NodePort>. Superset of ClusterIP.
#LoadBalancer - Creates an external load balancer in the current cloud (if supported) and assigns a fixed, external IP to the Service. Superset of NodePort.
#ExternalName - Exposes the Service using an arbitrary name (specified by externalName in the spec) by returning a CNAME record with the name. No proxy is used. This type requires v1.7 or higher of kube-dns.
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080

export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
kubectl label pod $POD_NAME app=v1

#### Instalacion de entorno MicroK8s ####
# Instalar multipass https://github.com/canonical/multipass/releases

# configurar y ejecutar la imagen de la máquina virtual de MicroK8s en (windows)
multipass launch --name microk8s-vm --memory 4G --disk 40G

#acceder a la instancia de máquina virtual (windows)
multipass shell microk8s-vm

#instalar microk8s
sudo snap install microk8s --classic

# Preparacion del cluster
sudo microk8s.status --wait-ready

#habilitará el DNS, el panel y los complementos del registro
sudo microk8s.enable dns dashboard registry

#asignar alias kubectl
sudo snap alias microk8s.kubectl kubectl

##Desinstalación de MicroK8s del multipass
sudo microk8s.disable dashboard dns registry
sudo snap remove microk8s
exit
multipass stop microk8s-vm
multipass delete microk8s-vm
multipass purge
########

##### Instalacion de servidor web en cluster ####

# pod
# conjunto de replicas = ReplicaSet
# implementacion = deployment

# crear la implementación de NGINX
kubectl create deployment nginx --image=nginx

# Ver implementacion 
sudo kubectl get deployments

# ver pods creados
sudo kubectl get pods

# Escalar replicas de deployment
sudo kubectl scale --replicas=3 deployments/nginx
sudo kubectl scale --replicas=1 deployments/xxxx

# Creación de un clúster de Azure Kubernetes Service
export RESOURCE_GROUP=rg-contoso-video
export CLUSTER_NAME=aks-contoso-video
export LOCATION=<myLocation> eastus
export LOCATION=eastus

# Ejecute el comando az group create para crear un grupo de recursos. Implemente todos los recursos en este nuevo grupo de recursos.
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

#ver nodos
kubectl get nodes

# Crear un deployment para implementacion de aplicacion
touch deployment.yaml

kubectl apply -f ./deployment.yaml
kubectl get deploy contoso-website
kubectl get pods

# Creacion de un servicio
touch service.yaml

kubectl apply -f ./service.yaml
kubectl get service contoso-website

# Creacion de un ingress

touch ingress.yaml

# consultar la lista de zonas de Azure DNS.
az network dns zone list

az aks show \
  -g $RESOURCE_GROUP \
  -n $CLUSTER_NAME \
  -o tsv \
  --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName

4abd73fbf90c4e39aa15.eastus.aksapp.io

kubectl apply -f ./ingress.yaml
kubectl get ingress contoso-website

#Eliminar aks
borrar security group
kubectl config delete-context aks-contoso-video


############ AKS con el escalador automático de clúster###########

kubectl create namespace costsavings

kubectl apply \
--namespace costsavings \
-f spot-node-deployment.yaml

kubectl get pods --namespace costsavings -o wide

#### Manejo de contextos en kubernetes ####

#current-context   Display the current-context
#delete-cluster    Delete the specified cluster from the kubeconfig
#delete-context    Delete the specified context from the kubeconfig
#delete-user       Delete the specified user from the kubeconfig
#get-clusters      Display clusters defined in the kubeconfig
#get-contexts      Describe one or many contexts
#get-users         Display users defined in the kubeconfig
#rename-context    Rename a context from the kubeconfig file
#set               Set an individual value in a kubeconfig file
#set-cluster       Set a cluster entry in kubeconfig
#set-context       Set a context entry in kubeconfig
#set-credentials   Set a user entry in kubeconfig
#unset             Unset an individual value in a kubeconfig file
#use-context       Set the current-context in a kubeconfig file
#view              Display merged kubeconfig settings or a specified kubeconfig file

# Ver contextos actuales
kubectl config get-contexts

kubectl config use-context [nombre-del-contexto]

kubectl config delete-context [nombre-del-contexto]

#### Manejo de secretos ####

#convertir certificado a pfx
openssl pkcs12 -in testapi.starbucks.pe.pem -inkey testapi_starbucks_pe.key -export -out certificado.pfx

# Crear secreto
kubectl create secret tls <nombre-secreto> --cert=<ruta-certificado> --key=<ruta-clave-privada>

kubectl create secret tls testapi.stackbucks.pe --cert=/home/daruischts/testapi_stackbucks_pe.crt --key=/home/daruischts/testapi_stackbucks_pe.key

#colocar el secreto en el deployment del ingress

#Reference:
# Azure AKS https://learn.microsoft.com/es-mx/azure/aks/
#Oracle CE https://docs.oracle.com/es-ww/iaas/Content/ContEng/Concepts/contengclustersnodes.htm#processes
# Kubernetes Path: https://learn.microsoft.com/es-es/training/paths/intro-to-kubernetes-on-azure/
# Azure Kubernetes Services https://azure.microsoft.com/es-mx/products/kubernetes-service/
# Microk8s https://microk8s.io/
# Datadog K8s https://learn.datadoghq.com/bundles/k8s-fundamentals
# Lab Oracle https://docs.oracle.com/en/learn/ol-kube/index.html#run-kubernetes-on-oracle-linux
# GKE https://www.cloudskillsboost.google/course_templates/2?catalog_rank=%7B%22rank%22%3A8%2C%22num_filters%22%3A0%2C%22has_search%22%3Atrue%7D&search_id=24353318
# Cert Let's Encrypt en K8s https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes-es

