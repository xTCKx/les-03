[app]
demoapp ansible_host=${vm_ip} 
%{ for i, web in web_vms ~}
${web.guest_name}: ansible_host: ${web.ip_address}
%{ endfor ~}

[app:vars]
app_name="demoapp"
ansible_user=kuromi
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_ssh_private_key_file=~/.ssh/id_ed25519-skylab