# 100 Days DevOps - Jour 83 : Introduction à Ansible

Ce petit projet fait partie du parcours 100 Days DevOps et a pour objectif de découvrir les bases d'Ansible avec un premier playbook simple.

## Objectif

Créer un fichier sur un serveur distant à l'aide d'un playbook Ansible.

## Structure du projet

- playbook.yml : le playbook Ansible qui crée le fichier /tmp/file.txt sur le host stapp01.
- inventory : le fichier d'inventaire contenant les informations de connexion du serveur cible.

## Prérequis

Avant d'exécuter ce projet, assurez-vous d'avoir :

- Ansible installé sur votre machine
- Un accès SSH au serveur cible
- Les bonnes informations d'authentification renseignées dans l'inventaire

## Utilisation

Exécutez la commande suivante depuis la racine du projet :

```bash
ansible-playbook -i inventory playbook.yml
```

## Ce que fait le playbook

Le playbook :

- cible le host stapp01
- se connecte en mode sudo
- crée le fichier /tmp/file.txt s'il n'existe pas déjà

## Notes

Ce projet est volontairement minimal pour apprendre les bases d'Ansible :

- les playbooks
- les inventaires
- l'exécution de tâches sur un hôte distant

Pour un usage réel, il est recommandé d'utiliser des clés SSH et de ne pas stocker les mots de passe en clair dans l'inventaire.
