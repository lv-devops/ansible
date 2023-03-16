#!/bin/bash

###  VARIABLES  #### 
# List of repo as variables
REPO_URLS=(
    "https://github.com/geerlingguy/ansible-role-php.git"
    "https://github.com/geerlingguy/ansible-role-php-versions.git"
    "https://github.com/geerlingguy/ansible-role-repo-epel.git"
    "https://github.com/geerlingguy/ansible-role-nginx.git"
    "https://github.com/bertvv/ansible-role-mariadb.git"
)

DIR_NAMES=(
  "ansible-role-mariadb"
  "ansible-role-nginx"
  "ansible-role-php-versions"
  "ansible-role-php"
  "ansible-role-repo-epel"
)

PATH_TO_CLONE="/tmp/demo"

#################################
# Create folder
mkdir -p $DIR_PATH/$ROLE_MARIADB

# Clone each repository to the specified path
for i in "${!REPO_URLS[@]}"
do
    git clone "${REPO_URLS[$i]}" "$PATH_TO_CLONE/${DIR_NAMES[$i]}"
done

sleep 10
######## Start ansible playbook
ansible-playbook -i hosts main.yml --ask-vault-pass