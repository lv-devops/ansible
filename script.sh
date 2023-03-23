#!/bin/bash
#set -euo pipefail


DIRPATH=/tmp/demo
mkdir -p $DIRPATH

# Check OS family system
OS=$(uname -s)

if [[ "$OS" == "Linux" ]]; then
  if [[ -f "/etc/debian_version" ]]; then
    echo "Debian or Ubuntu based system"
    if ! grep -q "ansible/ansible" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
      #export DEBIAN_FRONTEND=noninteractive
      sudo apt-add-repository ppa:ansible/ansible
      sudo apt update -y
    fi
    sudo apt install -y ansible
  elif [[ -f "/etc/redhat-release" ]]; then
    echo "Red Hat or CentOS based system"
    sudo yum install epel-release -y
    sudo yum update -y
    sudo yum install -y ansible git
  else
    echo "Unsupported Linux distribution"
  fi
else
  echo "Unsupported family Linux"
fi


git clone https://github.com/lv-devops/ansible.git $DIRPATH
echo "123" > ~/.vault_pass.txt
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt

ansible-galaxy install -r $DIRPATH/requirements.yml --force

ansible-playbook -i $DIRPATH/hosts $DIRPATH/main.yml --tags web