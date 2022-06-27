#!/bin/bash
curl -sfL https://get.rke2.io | sh -
export PATH=$PATH:/opt/rke2/bin

mkdir -p /etc/rancher/rke2/
touch /etc/rancher/rke2/config.yaml
cat <<EOF | sudo tee /etc/rancher/rke2/config.yaml
node-name:
  - "rke2-1"
token: my-shared-secret
EOF
systemctl enable --now rke2-server.service

curl -LO https://dl.k8s.io/release/v1.23.7/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
mkdir -p /home/rancher/.kube/
sudo cp /etc/rancher/rke2/rke2.yaml /home/rancher/.kube/config
sudo chown rancher -v /home/rancher/.kube/config
echo 'source <(kubectl completion bash)' >> /home/rancher/.bashrc
source /home/rancher/.bashrc
