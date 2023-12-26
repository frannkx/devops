#!/bin/bash

# Script for jenkins installation on Kubernetes

git clone https://github.com/scriptcamp/kubernetes-jenkins

k apply -f namespace.yaml 

kubectl apply -f serviceAccount.yaml

kubectl create -f volume.yaml

kubectl apply -f deployment.yaml

kubectl get deployments -n devops-tools

kubectl apply -f service.yaml

kubectl logs [pod-name]

f2edc8e0948545018d300aa1a566a343

#Reference: https://www.jenkins.io/doc/book/installing/kubernetes/

