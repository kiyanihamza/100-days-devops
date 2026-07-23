# Playbook: Deploy simple httpd web page (Stratos DC)

Ce README explique l'objectif du playbook, les modules utilisés, et pourquoi nous avons utilisé `insertafter: EOF` ainsi que d'autres choix de conception.

**Emplacement**: `/home/thor/ansible/playbook.yml`

**Inventaire attendu**: `/home/thor/ansible/inventory` (déjà présent sur le jump host)

**Objectif**
- Installer `httpd` sur les serveurs applicatifs.
- S'assurer que le service `httpd` est activé et démarré.
- Déployer une page d'accueil `/var/www/html/index.html` contenant le texte initial.
- Ajouter via `lineinfile` une ligne "Welcome to xFusionCorp Industries!" (idempotence garantie).
- Ajouter ensuite une note en français demandée par l'équipe.

**Commandes utiles**
```bash
ansible-playbook -i /home/thor/ansible/inventory /home/thor/ansible/playbook.yml --check
ansible-lint /home/thor/ansible/playbook.yml
ansible-playbook -i /home/thor/ansible/inventory /home/thor/ansible/playbook.yml
```

**Modules Ansible utilisés et pourquoi**
- `package` (ou `yum`/`apt` selon distro): installe le paquet `httpd`. Le module `package` est agnostique de la distribution et sélectionne le gestionnaire approprié; on préfère `package` pour la portabilité.
- `service`: gère l'état du service (`started`, `stopped`) et l'activation (`enabled`). On l'utilise pour s'assurer que `httpd` tourne et redémarre automatiquement après reboot.
- `copy`: crée ou remplace un fichier avec un contenu fourni directement depuis le playbook. Utilisé pour créer `/var/www/html/index.html` avec le contenu initial. `copy` est simple et idempotent pour des petits fichiers statiques.
- `ansible.builtin.lineinfile`: garantit qu'une ligne spécifique existe dans un fichier, sans réécrire entièrement le fichier. Idéal pour ajouter une ligne (ex: "Welcome to xFusionCorp Industries!") de façon idempotente.

Pourquoi choisir `lineinfile` pour ajouter la ligne "Welcome to xFusionCorp Industries!" ?
- Idempotence: `lineinfile` vérifie si la ligne est déjà présente et ne la duplique pas.
- Sélectivité: il n'écrase pas le fichier entier (contrairement à `copy` ou `template`) si on veut juste ajouter/modifier une ligne.
- Contrôle précis du positionnement via `insertafter` / `insertbefore`.

Explication de `insertafter: EOF`
- `insertafter` contrôle l'endroit où la nouvelle ligne est insérée.
- `EOF` signifie "End Of File" ; `insertafter: EOF` demande à Ansible d'ajouter la ligne à la fin du fichier si elle n'y est pas encore.
- Utiliser `insertafter: EOF` est approprié quand on veut s'assurer que la ligne apparaisse à la fin, par exemple pour ajouter un pied-de-page, une note ou une bannière.

Options importantes avec `lineinfile`
- `create: yes` : si le fichier n'existe pas, il sera créé.
- `owner` / `group` / `mode` : maintiennent les permissions et la propriété correctes pour que le serveur web puisse lire le fichier.
- `backrefs` : utile pour les remplacements avec des regex (non utilisé ici).

Remarques sur l'idempotence et la sécurité
- Le playbook doit être idempotent: le même playbook peut être réexécuté plusieurs fois sans effets secondaires indésirables (par exemple, pas de doublons dans le fichier).
- Préférer `--check` pour valider les changements attendus avant application.
- Utiliser `ansible-lint` pour vérifier les meilleures pratiques et éviter les erreurs courantes.

Conseils et bonnes pratiques
- Groupes d'hôtes: utilisez un groupe spécifique d'app servers dans votre inventaire (par ex. `[app_servers]`) et mettez `hosts: app_servers` dans le playbook plutôt que `hosts: all` pour éviter d'affecter d'autres machines.
- Tests: exécutez d'abord en `--check` puis sur un petit sous-ensemble d'hôtes avant un déploiement global.
- Permissions: `owner: apache` / `group: apache` et permissions `0644` sont standards pour les fichiers web statiques sur RHEL/CentOS; adaptez selon la distro.

Exemple minimal d'une tâche `lineinfile` pour append à la fin:
```yaml
- name: Add welcome line to index
  ansible.builtin.lineinfile:
    path: /var/www/html/index.html
    line: "Welcome to xFusionCorp Industries!"
    insertafter: EOF
    create: yes
```

Questions fréquentes
- Pourquoi `copy` + `lineinfile` et pas uniquement `copy` ?
  - `copy` remplace le fichier entier; si vous voulez garder un fichier géré partiellement par d'autres mécanismes (ou ajouter plusieurs lignes séparément), `lineinfile` est préférable pour des modifications ciblées.
- `insertafter: EOF` ajoute-t-il une nouvelle ligne si le fichier n'a pas de saut de ligne final ?
  - Oui, Ansible s'assure que la ligne est ajoutée proprement à la fin.

Support
Si vous voulez, je peux:
- lancer `ansible-lint /home/thor/ansible/playbook.yml` et partager les retours,
- exécuter `ansible-playbook --check` contre `/home/thor/ansible/inventory` (si vous me donnez le contenu de l'inventory ou m'autorisez à l'utiliser),
- ou adapter le playbook pour d'autres distributions (Debian/Ubuntu) en utilisant `apt` au lieu de `yum`.
