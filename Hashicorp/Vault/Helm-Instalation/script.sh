#!/bin/bash

helm repo add hashicorp https://helm.releases.hashicorp.com

echo "apiVersion: v2
name: vault
description: A Helm chart for HashiCorp Vault
version: 0.25.0
appVersion: 1.14.0
" > Chart.yaml

find / -name Chart.yaml 2>/dev/null

echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: vault
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vault
  template:
    metadata:
      labels:
        app: vault
    spec:
      containers:
      - name: vault
        image: hashicorp/vault:latest
        ports:
        - containerPort: 8200
        env:
        - name: VAULT_DEV_ROOT_TOKEN_ID
          value: "root"
" > deployment.yaml

helm install vault hashicorp/vault



