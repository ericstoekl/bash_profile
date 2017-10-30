#!/bin/bash

sudo su
apt install unzip
curl -sL https://gist.githubusercontent.com/alexellis/7315e75635623667c32199368aa11e95/raw/b025dfb91b43ea9309ce6ed67e24790ba65d7b67/kube.sh | sh
IP=`ifconfig ens3 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$IP --kubernetes-version stable-1.8

exit
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml


# FAAS
curl -sSL https://github.com/ericstoekl/faas-netes/archive/replicaStatus.zip > replicaStatus.zip
unzip replicaStatus.zip
cd faas-netes-replicaStatus/
#kubectl apply -f ./faas.yml,monitoring.yml
#kubectl apply -f ./rbac.yml
