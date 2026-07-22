# Projet Ansible Day 84

Ce dépôt contient un petit projet Ansible pour déployer un fichier HTML sur un ensemble de serveurs d'application.

## Structure du projet

- `inventory` : inventaire Ansible listant les hôtes cibles et leurs informations de connexion.
- `playbook.yml` : playbook Ansible exécutant une tâche de copie d'un fichier sur tous les serveurs.
- `README.md` : documentation du projet.

## Objectif

Le playbook copie le fichier local `/usr/src/sysops/index.html` vers le répertoire distant `/opt/sysops` sur tous les hôtes définis dans l'inventaire.

## Hôtes définis

L'inventaire contient les serveurs suivants :

- `stapp01` avec l'utilisateur `tony`
- `stapp02` avec l'utilisateur `steve`
- `stapp03` avec l'utilisateur `banner`

Chaque hôte possède également les mots de passe SSH et de privilèges de `become` correspondants.

## Utilisation

1. Placer le fichier `index.html` dans `/usr/src/sysops/` sur la machine de contrôle Ansible.
2. Tester l'inventaire et la connectivité vers tous les hôtes avec :

```bash
ansible all -i inventory -m ping
```

3. Exécuter le playbook depuis le répertoire du projet :

```bash
ansible-playbook -i inventory playbook.yml
```

## Prérequis

- Ansible installé sur la machine de contrôle.
- Accès réseau vers les machines cibles.
- Le chemin source `/usr/src/sysops/index.html` doit exister sur le contrôleur.
- Les informations d'accès dans `inventory` doivent être correctes.

## Notes

- Le playbook utilise `become: yes` pour exécuter la copie avec des privilèges élevés sur les hôtes distants.
- Si nécessaire, adaptez les chemins, les utilisateurs ou les mots de passe dans le fichier `inventory`.
- Pour un usage en production, il est recommandé de sécuriser l'inventaire et de ne pas stocker les mots de passe en clair.
