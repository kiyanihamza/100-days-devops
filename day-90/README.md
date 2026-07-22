# Ansible ACL Task — Explication et Bonnes Pratiques

## Objectif
Ce projet contient un playbook Ansible (`playbook.yml`) qui crée des fichiers vides sur trois serveurs d'application et définit des permissions ACL spécifiques pour chaque fichier.

### Ce qui est demandé
- Créer un fichier vide sur chaque serveur dans `/opt/finance` :
  - `blog.txt` sur `stapp01`
  - `story.txt` sur `stapp02`
  - `media.txt` sur `stapp03`
- Les fichiers doivent être possédés par l'utilisateur `root`.
- Chaque fichier doit recevoir des permissions ACL pour un utilisateur ou un groupe précis.
- La validation se fera avec la commande :
  ```bash
  ansible-playbook -i inventory playbook.yml
  ```
  sans arguments supplémentaires.

## Pourquoi cette solution
J'ai proposé un seul playbook global avec `hosts: all` pour :
- garder la syntaxe Ansible correcte,
- appliquer la logique selon le serveur cible,
- éviter les erreurs de structure YAML.

### Avantages de cette approche
- La structure du playbook est standard pour Ansible.
- `become: yes` garantit que les tâches sont exécutées avec les droits root.
- Le répertoire `/opt/finance` est créé une seule fois de manière idempotente.
- Les trois fichiers sont créés seulement sur le serveur correspondant.
- Les fichiers sont explicitement possédés par `root`.
- Les ACL sont ajoutées uniquement sur le bon fichier.

## Ce que j'ai corrigé par rapport à l'erreur initiale
### Erreurs à éviter
- `host:` au lieu de `hosts:` : Ansible ne reconnaît pas `host` dans une play.
- Oublier `become: yes` lorsque l'on travaille sur des fichiers sous `/opt` et avec `root`.
- Ne pas définir `owner: root` et `group: root` pour les fichiers.
- Omettre la création du répertoire `/opt/finance` avant de toucher le fichier.
- Confondre les serveurs : chaque fichier doit être créé sur le bon hôte.
- Utiliser une syntaxe incorrecte ou un mauvais module ACL.

### Points d'attention
- `inventory_hostname` doit être comparé avec le nom exact du host dans l'inventaire.
- Le module `ansible.posix.acl` fonctionne avec `entity`, `etype`, `permissions` et `state: present`.
- Le module `ansible.builtin.file` est utilisé pour créer le fichier et fixer la propriété.
- Il faut vérifier que le module ACL est disponible sur les hôtes (package `acl` installé sur Linux).

## Ce que vous devez éviter pour répondre correctement
- Ne pas écrire plusieurs playbooks séparés si la consigne demande un seul `playbook.yml`.
- Ne pas utiliser d'options de ligne de commande différentes de la commande de validation.
- Ne pas négliger la création du dossier parent.
- Ne pas se contenter de créer les fichiers sans définir la propriété `root`.
- Ne pas appliquer les ACL sur le mauvais fichier ou le mauvais serveur.

## Conseils pour apprendre et ne plus se tromper
- Toujours vérifier la structure d'une playbook Ansible :
  - `- name:` au niveau play,
  - `hosts:` pour cibler les serveurs,
  - `become:` pour l'élévation,
  - `tasks:` comme liste.
- Pour chaque tâche, vérifier que le module utilisé est le bon.
- Penser en étapes :
  1. créer le dossier,
  2. créer le fichier,
  3. fixer la propriété,
  4. appliquer les ACL.
- Tester localement avec une commande simple avant de valider.
- Lire attentivement la demande : ici, le but n'est pas de modifier les permissions Unix classiques mais d'ajouter des ACL précises.

## Résultat attendu
Le playbook doit :
- fonctionner directement avec `ansible-playbook -i inventory playbook.yml`,
- créer les fichiers sur les bons serveurs,
- définir `root` comme owner,
- appliquer les ACL demandées :
  - `tony` en tant que groupe avec `r` sur `blog.txt`,
  - `steve` en tant qu'utilisateur avec `rw` sur `story.txt`,
  - `banner` en tant que groupe avec `rw` sur `media.txt`.

---

Bonne pratique : relire les consignes, vérifier la syntaxe Ansible et tester une seule fois la commande de validation attendue.