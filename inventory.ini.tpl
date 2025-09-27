[app]
demoapp ansible_host=${vm_ip}

[app:vars]
app_name="demoapp"
ansible_user=kuromi
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_ssh_private_key_file=~/.ssh/id_ed25519-skylab