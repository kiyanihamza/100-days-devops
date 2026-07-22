# Ansible - Configuration SSH sans mot de passe et test de ping

## Contexte du scénario

L’équipe Nautilus DevOps doit valider plusieurs playbooks Ansible sur des serveurs applicatifs de Stratos DC. Avant de lancer les tests, il est nécessaire d’établir une connexion SSH sans mot de passe entre le serveur Ansible controller et les nœuds gérés.

Dans ce laboratoire, le serveur de contrôle est la machine jump host, et l’utilisateur utilisé pour exécuter Ansible est `thor`.

Le fichier d’inventaire utilisé pour le test est :

```bash
/home/thor/ansible/inventory
```

Le fichier d’inventaire fourni dans ce workspace contient un exemple pour l’hôte App Server 2 :

```ini
[app_servers]
stapp02 ansible_user=steve ansible_ssh_pass=Am3ric@
```

## Objectif

- Configurer une authentification SSH basée sur des clés depuis la jump host vers App Server 2.
- Vérifier que la communication fonctionne avec Ansible.
- Documenter la procédure de manière professionnelle pour un usage opérationnel.

## Prérequis

- Accès à la jump host en tant que `thor`.
- Un accès valide au serveur cible `stapp02`.
- Ansible installé sur la jump host.
- Le mot de passe de test pour l’hôte cible, à utiliser uniquement dans un environnement de laboratoire.

## Procédure recommandée

### 1. Se connecter à la jump host

```bash
ssh thor@<jump-host>
```

### 2. Générer une paire de clés SSH

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519
```

### 3. Copier la clé publique vers App Server 2

Si `sshpass` est disponible, vous pouvez utiliser cette méthode pour la première copie :

```bash
sshpass -p 'Am3ric@' ssh-copy-id -o StrictHostKeyChecking=no <remote-user>@stapp02
```

Remplacez `<remote-user>` par l’utilisateur distant approprié (par exemple `root` ou un utilisateur système défini sur la cible).

Exemple avec `root` :

```bash
sshpass -p 'Am3ric@' ssh-copy-id -o StrictHostKeyChecking=no root@stapp02
```

### 4. Vérifier la connexion SSH sans mot de passe

```bash
ssh -o StrictHostKeyChecking=no <remote-user>@stapp02
```

Si la connexion réussit sans demander de mot de passe, la configuration est correcte.

### 5. Tester la connectivité avec Ansible

Exécuter la commande depuis la jump host :

```bash
ansible -i /home/thor/ansible/inventory stapp02 -m ping
```

Si la connexion est correcte, Ansible doit retourner une sortie similaire à :

```text
stapp02 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

## Vérifications utiles

- Vérifier la présence de la clé publique sur le serveur distant :

```bash
cat ~/.ssh/authorized_keys
```

- Vérifier les permissions SSH :

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Résolution des problèmes courants

### Erreur : Permission denied (publickey)

- Vérifier que la clé publique a bien été copiée sur le serveur cible.
- Vérifier que le fichier `authorized_keys` a les permissions correctes.
- Vérifier que l’utilisateur distant utilisé dans la commande existe bien sur la cible.

### Erreur : Host key verification failed

- Ajouter l’option :

```bash
-o StrictHostKeyChecking=no
```

### Erreur : No route to host

- Vérifier l’adresse réseau du serveur cible.
- Vérifier la connectivité réseau entre la jump host et App Server 2.

## Questions de revue

1. Pourquoi faut-il mettre en place une connexion SSH sans mot de passe avant d’exécuter des playbooks Ansible ?
2. Quel est le rôle du fichier d’inventaire dans une utilisation Ansible ?
3. Quelle commande permet de tester rapidement la connectivité Ansible vers un hôte donné ?
4. À quoi sert la commande `ssh-copy-id` dans ce scénario ?
5. Quels risques existent si l’authentification SSH repose uniquement sur des mots de passe ?
6. Comment sécuriser la distribution des clés SSH dans un environnement de production ?

## Conclusion

Une fois la connexion SSH sans mot de passe établie et la commande Ansible de test réussie, l’équipe peut passer à l’exécution des playbooks en toute confiance sur les serveurs distants.
