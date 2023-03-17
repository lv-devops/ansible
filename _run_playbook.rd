# ver. 0.1
# ochyr

# Download requirement roles
ansible-galaxy install -r requirements.yml --force
# Start playbook
ansible-playbook -i hosts main.yml --ask-vault-pass