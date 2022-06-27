#!/bin/bash
systemctl disable apparmor.service
systemctl disable firewalld.service
systemctl stop apparmor.service
systemctl stop firewalld.service

curl -sfL https://get.rke2.io | sh -
export PATH=$PATH:/opt/rke2/bin

mkdir -p /etc/rancher/rke2/
touch /etc/rancher/rke2/config.yaml
cat <<EOF | sudo tee /etc/rancher/rke2/config.yaml
server: https://192.168.122.11:9345
node-name:
  - "rke2-3"
token: my-shared-secret
EOF
systemctl enable --now rke2-server.service
