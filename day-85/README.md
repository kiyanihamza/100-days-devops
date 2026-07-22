# Day 85 - Ansible Playbook

Ce dépôt contient un projet Ansible simple qui crée un fichier vide sur plusieurs serveurs d'application.

## Structure du projet

- `inventory`
  - Décrit les hôtes cibles et les informations de connexion Ansible.
  - Serveurs définis : `stapp01`, `stapp02`, `stapp03`.
- `playbook.yml`
  - Playbook Ansible principal.
  - Il s'exécute sur tous les hôtes (`hosts: all`) et crée le fichier `/home/webdata.txt`.

## Contenu du playbook

Le playbook effectue les actions suivantes :

- cible `hosts: all`
- élève les privilèges avec `become: yes`
- utilise le module `ansible.builtin.file`
- crée un fichier vide à l'emplacement `/home/webdata.txt`

Voici le contenu principal du playbook :

```yaml
- name: Create a blank file /home/webdata.txt on all app servers
  hosts: all
  become: yes

  tasks:
    - name: Create file on all app servers
      ansible.builtin.file:
        path: /home/webdata.txt
        state: touch
```

## Prérequis

- Ansible installé sur la machine de contrôle
- Accès SSH vers les hôtes définis dans `inventory`
- Les informations de connexion (utilisateur, mot de passe) doivent être correctes

## Exécution

Depuis le répertoire `day-85`, lancez la commande suivante :

```bash
ansible-playbook -i inventory playbook.yml
```

## Sécurité

- L'inventaire contient des mots de passe en clair, ce qui n'est pas recommandé en production.
- Améliorez la sécurité en utilisant :
  - `ansible-vault` pour chiffrer l'inventaire ou les variables sensibles
  - des clés SSH au lieu de mots de passe

## Personnalisation

- Modifiez `inventory` pour changer les hôtes ou les informations de connexion
- Ajoutez des tâches supplémentaires dans `playbook.yml`
- Changez le chemin du fichier si vous voulez créer un autre emplacement
