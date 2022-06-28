#!/bin/bash

wget https://get.helm.sh/helm-v3.9.0-linux-amd64.tar.gz
tar -zxvf helm-v3.9.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

kubectl create ns cert-manager 
kubectl create namespace cattle-system

kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml

helm repo add jetstack https://charts.jetstack.io
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo update

helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.7.1

helm install rancher rancher-stable/rancher --namespace cattle-system --set hostname=rancher.example.com --set replicas=3
