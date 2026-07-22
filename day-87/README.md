# Day 87 - Ansible playbook

Ce dossier contient un playbook Ansible simple pour installer le paquet `logrotate` sur les serveurs définis dans le fichier d’inventaire.

## Contenu

- `playbook.yml` : playbook principal qui installe `logrotate` sur tous les hôtes ciblés.
- `inventory` : liste des hôtes et leurs informations de connexion.

## Prérequis

- Ansible installé sur votre machine locale.
- Accès SSH aux hôtes cibles.
- Les hôtes doivent avoir un gestionnaire de paquets compatible `yum`.

## Exécution

Vérifier la syntaxe :

```bash
ansible-playbook -i inventory playbook.yml --syntax-check
```

Exécuter le playbook :

```bash
ansible-playbook -i inventory playbook.yml
```

## Notes

- Le fichier `inventory` contient des exemples de connexions ; adaptez-les à votre environnement.
- Le playbook utilise `become: true` pour exécuter les tâches avec les privilèges nécessaires.
