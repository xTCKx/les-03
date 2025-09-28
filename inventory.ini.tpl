[all:vars]
ansible_user=kuromi
ansible_ssh_common_args="-o StrictHostKeyChecking=no"
ansible_ssh_private_key_file=~/.ssh/id_ed25519-skylab

[all]
%{ for i, web in web_vms ~}
${web.guest_name} ansible_host=${web.ip_address}
%{ endfor ~}
${db_vms.guest_name} ansible_host=${db_vms.ip_address}

[db]
${db_vms.guest_name} ansible_host=${db_vms.ip_address}

[web]
%{ for i, web in web_vms ~}
${web.guest_name} ansible_host=${web.ip_address}
%{ endfor ~}
