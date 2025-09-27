## import_tasks
- Laadt tasks tijdens parsing (statisch)
- Alle tasks zijn zichtbaar in playbook output
- Gebruik voor: vaste task sets die altijd uitgevoerd worden

## include_tasks
- Laadt tasks tijdens runtime (dynamisch)
- Tasks worden pas geladen wanneer nodig
- Gebruik voor: conditionele tasks of loops

## Wanneer Roles gebruiken?
- Herbruikbaarheid: Dezelfde role in meerdere playbooks
- Organisatie: Gestructureerde mappenindeling
- Onderhoud: Gemakkelijker te debuggen en updaten
- Delen: Roles kunnen gedeeld worden via Ansible Galaxy