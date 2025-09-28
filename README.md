## Ubuntu VM Deployment
Deploy de Ubuntu VM met Terraform:

```bash
terraform init
terraform plan
terraform apply
```

De VM wordt gemaakt op de ESXi met cloud-init configuratie via `metadata.yaml` en `userdata.yaml`.

## Ansible Configuration
Ansible is configureerd via `ansible.cfg` om de automitisch gegenereerde `inventory.ini` van Terraform te gebruiken.

Run het playbook:

```bash
ansible-playbook playbook.yml
```
Het playbook voert basissysteemconfiguratie uit, waaronder MOTD-installatie, pakketinstallatie (curl), fact gathering en file checks.

