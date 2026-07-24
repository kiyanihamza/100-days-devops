# Déploiement d'un Security Group avec Terraform

Ce projet Terraform permet de créer un security group AWS dans la VPC par défaut avec deux règles d'entrée :

- HTTP sur le port 80 depuis 0.0.0.0/0
- SSH sur le port 22 depuis 0.0.0.0/0

## Contenu du projet

- `main.tf` : contient la configuration Terraform pour créer le security group.
- `provider.tf` : contient la configuration du provider AWS et la région utilisée.

## Prérequis

Avant de lancer ce projet, assurez-vous d'avoir :

- Terraform installé sur votre machine
- Un accès AWS configuré
- Les droits nécessaires pour créer des ressources EC2 et des security groups

## Utilisation

1. Initialiser Terraform :
   ```bash
   terraform init
   ```

2. Vérifier le plan de déploiement :
   ```bash
   terraform plan
   ```

3. Appliquer la configuration :
   ```bash
   terraform apply
   ```

## Ressource créée

Le projet crée une ressource `aws_security_group` nommée :

- `datacenter-sg`

Avec la description suivante :

- `Security group for Nautilus App Servers`
