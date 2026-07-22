# Ansible Playbook for Web Server Deployment

## Scénario professionnel
Dans le cadre de l'administration système et de l'automatisation DevOps, l'équipe doit déployer et maintenir un serveur web Apache HTTPD sur les machines applicatives du centre de données Stratos. Cette tâche doit être automatisée afin de réduire les erreurs manuelles, garantir la conformité et accélérer la mise à disposition des services.

## Objectif opérationnel
Installer, démarrer et activer le service HTTPD sur tous les serveurs applicatifs ciblés via Ansible, en utilisant un playbook unique et un inventaire déjà préparé.

## Pourquoi ce travail avant le "comment"
Avant de détailler la procédure, il est essentiel de comprendre le contexte opérationnel :
- le besoin métier est de standardiser le déploiement des services ;
- l'automatisation évite les interventions manuelles répétitives ;
- la conformité est renforcée grâce à une exécution contrôlée et reproductible ;
- le playbook devient un support de gouvernance technique pour l'équipe DevOps.

## Pré-requis
- Un serveur de jump host avec Ansible installé
- Un inventaire contenant les hôtes applicatifs
- Accès SSH configuré pour les machines cibles

## Fichiers fournis
- inventory : liste des serveurs cibles
- playbook.yml : playbook Ansible pour installer et gérer HTTPD
- ansible.cfg : configuration Ansible locale

## Exécution
Exécuter la commande suivante depuis le répertoire contenant les fichiers :

```bash
ansible-playbook -i inventory playbook.yml
```

## Résultat attendu
Le paquet HTTPD doit être installé, puis le service doit être lancé et activé au démarrage sur tous les serveurs ciblés.
