#!/bin/bash
#set -euo pipefail


DIRPATH=/tmp/demo
mkdir -p $DIRPATH



# Check the Linux distribution
if [[ $(lsb_release -si) == "Ubuntu" ]] || [[ $(lsb_release -si) == "Debian" ]]; then
    echo "Debian or Ubuntu based system"
    if ! grep -q "ansible/ansible" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
      #export DEBIAN_FRONTEND=noninteractive
      sudo apt-add-repository ppa:ansible/ansible
      sudo apt update -y
    fi
    sudo apt install -y ansible
elif [[ $(lsb_release -si) == "CentOS" ]] || [[ $(lsb_release -si) == "RedHat" ]]; then
    echo "Red Hat or CentOS based system"
    sudo yum install epel-release -y
    sudo yum update -y
    sudo yum install -y ansible git
else
    echo "Unsupported distribution"
    exit 1
fi


git clone https://github.com/lv-devops/ansible.git $DIRPATH
echo "123" > ~/.vault_pass.txt
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt

ansible-galaxy install -r $DIRPATH/requirements.yml --force

ansible-playbook -i $DIRPATH/hosts $DIRPATH/main.yml --tags web