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
ansible-playbook -c local -i ansible/hosts ansible/playbook-base.yml

if [[ "${BOOTSTRAP_TARGET}" == "RABBITMQ" ]]; then
  echo "Installing and configuring RabbitMQ cluster"
  ansible-playbook -c local -i ansible/hosts ansible/playbook-rabbitmq.yml
fi

if [[ "${BOOTSTRAP_TARGET}" == "MYSQL" ]]; then
  echo "Installing and configuring MySql cluster"
  ansible-galaxy collection install community.mysql
  python -m pip install PyMySQL
  ansible-playbook -c local -i ansible/hosts ansible/playbook-mysql.yml
fi
