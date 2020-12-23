#!/usr/bin/env bash

echo "Bootstrapping $(hostname) with ip address $(hostname -I) for environment ${BOOTSTRAP_TARGET}"

# Ensure that python3 is symlinked to python
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
#update our apt cache
sudo apt-get update
sudo apt-get install -y python3-pip
# Ensure pip is upgraded
python -m pip install -U pip
#Install ansible
python -m pip install ansible

ansible-galaxy install -r ansible/galaxy-requirements-base.yml
ansible-playbook -c local -i localhost ansible/playbook-base.yml
