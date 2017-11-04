curl -sSL https://get.docker.com | sudo sh
sudo usermod ubuntu -aG docker
git clone https://github.com/ericstoekl/bash_profile
cp bash_profile/.bash* .
git clone https://github.com/ericstoekl/faas
git checkout -b replicaStatus origin/replicaStatus

sudo mv bash_profile/faas-cli /usr/local/bin/faas-cli
