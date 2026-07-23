# Ansible role pour HTTPD sur App Server 3

Ce projet configure un serveur Apache HTTPD sur App Server 3 avec une page d'accueil personnalisée générée par Ansible.

## Objectif

L'objectif est de :
- installer le paquet HTTPD,
- démarrer et activer le service,
- copier un fichier index.html personnalisé depuis un template Jinja2,
- définir les permissions et le propriétaire du fichier de manière dynamique.

## Fichiers principaux

- [playbook.yml](playbook.yml) : définit le playbook qui cible App Server 3 et exécute le rôle HTTPD.
- [inventory](inventory) : contient l'hôte cible ainsi que l'utilisateur Ansible à utiliser.
- [role/httpd/tasks/main.yml](role/httpd/tasks/main.yml) : contient les tâches d'installation, de démarrage du service et de déploiement du template.
- [role/httpd/templates/index.html.j2](role/httpd/templates/index.html.j2) : template Jinja2 utilisé pour générer la page HTML.

## Pourquoi ce rôle est utile

Le rôle permet d'automatiser entièrement la configuration d'un serveur web. Au lieu de modifier manuellement le fichier HTML sur chaque hôte, Ansible rend la configuration répétable, rapide et fiable.

Le template utilise la variable `{{ inventory_hostname }}` afin d'afficher automatiquement le nom du serveur courant. Cela évite de coder en dur un nom de machine dans le fichier HTML.

## Ce qui a été configuré

### 1. Ciblage du bon serveur
Le playbook est défini pour s'exécuter sur `stapp03` via le fichier d'inventaire.

### 2. Installation et démarrage de HTTPD
Le rôle installe le paquet `httpd` et s'assure que le service est démarré et activé au démarrage.

### 3. Déploiement du fichier index.html
Le rôle copie le template Jinja2 vers :

`/var/www/html/index.html`

Le fichier reçoit ensuite :
- les permissions `0777`,
- le propriétaire et le groupe correspondant à l'utilisateur défini dans l'inventaire.

## Comment exécuter le playbook

Depuis le dossier du projet, exécutez :

```bash
ansible-playbook -i inventory playbook.yml
```

## Remarque importante

Pour que le déploiement fonctionne correctement, l'utilisateur défini dans l'inventaire doit être le bon utilisateur système du serveur cible. Dans cet exemple, l'hôte `stapp03` utilise `banner`.
