# Playbook Ansible — Stratos DC app servers

Ce dépôt contient un playbook Ansible (`playbook.yml`) qui utilise des conditions `when` (variable de faits `ansible_nodename`) pour déployer des fichiers différents vers trois serveurs d'application.

## Objectif

- Copier `/usr/src/data/blog.txt` depuis le jump host vers `/opt/data/blog.txt` sur `App Server 1` (propriétaire `tony`, permissions `0755`).
- Copier `/usr/src/data/story.txt` depuis le jump host vers `/opt/data/story.txt` sur `App Server 2` (propriétaire `steve`, permissions `0755`).
- Copier `/usr/src/data/media.txt` depuis le jump host vers `/opt/data/media.txt` sur `App Server 3` (propriétaire `banner`, permissions `0755`).

Le playbook est exécuté pour `- hosts: all` et décide quelle tâche exécuter via `when: ansible_nodename == 'stappXX'`.

## Prérequis

- Exécuter le playbook depuis le jump host qui contient le répertoire `inventory` (fichier d'inventaire attendu à la racine du workspace).
- Les fichiers à copier doivent exister sur le jump host sous `/usr/src/data/` : `blog.txt`, `story.txt`, `media.txt`.
- Les comptes utilisateurs `tony`, `steve` et `banner` doivent être présents sur les serveurs cibles si vous voulez que `owner`/`group` soient appliqués.
- Ansible installé sur le jump host.

## Emplacement attendu

- Inventaire : `inventory` (fichier à la racine du workspace)
- Playbook : `playbook.yml`

## Commandes

Lancer le playbook (commande de validation automatique) :

```bash
ansible-playbook -i inventory playbook.yml
```

Vérifications utiles :

```bash
ansible-playbook --syntax-check playbook.yml
ansible-lint playbook.yml
```

## Remarques

- Le playbook utilise la variable de faits `ansible_nodename` pour choisir la tâche à exécuter par noeud. Les noms attendus sont `stapp01`, `stapp02`, `stapp03`.
- Le module `copy` transfère les fichiers depuis le contrôleur (jump host) vers les cibles — c'est le comportement attendu si vous exécutez la commande depuis le jump host.

Si vous voulez que je valide ou exécute une vérification supplémentaire, dites-moi ce que vous souhaitez que j'ajoute.
