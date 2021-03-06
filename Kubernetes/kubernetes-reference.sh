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
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
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

