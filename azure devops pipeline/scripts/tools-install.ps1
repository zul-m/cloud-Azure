#  install zip to extract later our artifacts
sudo apt install zip

#  install jq we are going to us it when we show our tfplan
sudo apt install jq 

#  Azure-CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#  install Docker
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#  install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin