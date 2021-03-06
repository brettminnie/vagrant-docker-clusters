#!/usr/bin/env bash

echo "Bootstrapping $(hostname) with ip address $(hostname -I) for environment ${BOOTSTRAP_TARGET}"

# Suppress stdin warnings
export DEBIAN_FRONTEND=noninteractive

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

if [[ "${BOOTSTRAP_TARGET}" == "RABBITMQ" ]]
then
  echo "Installing and configuring RabbitMQ cluster"
  ansible-playbook -c local -i ansible/hosts ansible/playbook-rabbitmq.yml
elif [[ "${BOOTSTRAP_TARGET}" == "MYSQL" ]]
then
  echo "Installing and configuring MySql cluster"
  ansible-galaxy collection install community.mysql
  python -m pip install PyMySQL
  ansible-playbook -c local -i ansible/hosts ansible/playbook-mysql.yml
elif [[ "${BOOTSTRAP_TARGET}" == "REDIS" ]]
then
  echo "Installing and configuring Redis cluster"
  ansible-playbook -c local -i ansible/hosts ansible/playbook-redis.yml
else
  echo "No environment targeted, must be one of RABBITMQ, MYSQL or REDIS"
fi
