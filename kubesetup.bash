#!/bin/bash

HOMEDIR='/home/ubuntu'
cd $HOMEDIR
#sudo su
sudo apt install unzip
curl -sL https://gist.githubusercontent.com/alexellis/7315e75635623667c32199368aa11e95/raw/b025dfb91b43ea9309ce6ed67e24790ba65d7b67/kube.sh | sudo sh
IP=`ifconfig ens3 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$IP --kubernetes-version stable-1.8 > startup_log.txt

#su ubuntu
mkdir -p $HOMEDIR/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOMEDIR/.kube/config
sudo chown 1000:1000 $HOMEDIR/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml >> startup_log.txt
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml >> startup_log.txt
kubectl taint nodes --all node-role.kubernetes.io/master- >> startup_log.txt



# FAAS
curl -sSL https://github.com/ericstoekl/faas-netes/archive/replicaStatus.zip > replicaStatus.zip
unzip replicaStatus.zip
cd faas-netes-replicaStatus/
kubectl apply -f ./faas.yml,monitoring.yml
kubectl apply -f ./rbac.yml

# Get the cli
curl -sL https://cli.openfaas.com | sudo sh
