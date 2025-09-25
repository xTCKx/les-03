# VM Deployment and Ansible Usage

## Prerequisites
- Terraform geïnstalleerd
- Ansible geïnstalleerd
- Cloud provider credentials geconfigureerd (voor Azure)
- SSH key pair gegenereerd
- Toegang tot ESXi host voor lokale VM deployment

## VM Deployment

### 1. Clone de Repository
```bash
git clone <repository-url>
cd les-03
```

### 2. Configureer Terraform Variabelen (indien nodig)
Bewerk de variabele bestanden in de `terraform/` directory indien de standaardwaarden niet overeenkomen met je omgeving:
- `variabelen-esxi.tf`: Voor ESXi VM deployment
- `variabelen-azure.tf`: Voor Azure VM deployment

Voor ESXi deployment, zorg ervoor dat:
- `esxi_hostname`, `esxi_username`, `esxi_password` correct zijn ingesteld
- De OVF source URL toegankelijk is

Voor Azure deployment, zorg ervoor dat:
- Azure credentials zijn geconfigureerd (bijv. via `az login`)
- De resource group naam uniek is

### 3. Initialiseer Terraform
```bash
cd terraform
terraform init
```

### 4. Plan de Deployment
```bash
terraform plan
```
Bekijk de output om te controleren welke resources aangemaakt zullen worden.

### 5. Deploy de VMs
```bash
terraform apply
```
Typ `yes` om door te gaan met de deployment.

Na succesvolle deployment worden de IP adressen van alle VMs opgeslagen in `vm_ip_addresses.txt`.

### 6. Controleer de Deployment
```bash
cat vm_ip_addresses.txt
```
Dit bestand bevat alle IP adressen van de deployed VMs (ESXi webservers, database server, en Azure VMs).

## Ansible Usage

### Prerequisites voor Ansible
- SSH toegang tot de deployed VMs
- Ansible geïnstalleerd op je lokale machine
- SSH private key beschikbaar (standaard: `~/.ssh/id_ed25519-skylab`)

### 1. Update Inventory
Bewerk `ansible/inventory.ini` en vervang de IP adressen met de daadwerkelijke IP adressen van de deployed VMs:
- `app-server1` en `app-server2`: IP adressen van de ESXi webservers
- `database-server1`: IP adres van de ESXi database server

De Azure VMs kunnen ook toegevoegd worden aan de inventory indien gewenst.

### 2. Test Connectiviteit
Test de SSH connectiviteit met alle hosts:
```bash
cd ansible
ansible -i inventory.ini all -m ping
```

### 3. Voer Playbooks Uit
Voer de beschikbare playbooks uit om de VMs te configureren:

#### Basis Tools Installeren
```bash
ansible-playbook -i inventory.ini playbooks/04_basic_tools.yml
```
Deze playbook:
- Installeert basis tools op app servers (git, htop, nano, tree)
- Installeert database packages op db server (postgresql, mariadb-server)
- Creëert/verwijdert gebruikers zoals gedefinieerd in de inventory variabelen
- Creëert user-specifieke directories

#### Andere Playbooks
- `02_packages_services.yml`: Installeert packages en services
- `03_multi_group.yml`: Voorbeeld van multi-group configuratie

### 4. Ad-hoc Commando's
Voor snelle taken kun je ad-hoc commando's gebruiken:

#### Ping Test (ad-hoc manier)
```bash
ansible -i inventory.ini all -a "ping -c 4 {{ ansible_host }}"
```

#### Module Ping (aanbevolen)
```bash
ansible -i inventory.ini all -m ansible.builtin.ping
```

### 5. Troubleshooting
- Zorg ervoor dat SSH keys correct zijn geconfigureerd
- Controleer firewall settings op de VMs
- Gebruik `ansible -i inventory.ini <host> -m setup` voor systeem informatie
- Controleer Ansible logs voor gedetailleerde foutmeldingen

## Verwijderen
Om alle resources te verwijderen:
```bash
cd terraform
terraform destroy
```
Typ `yes` om te bevestigen.
