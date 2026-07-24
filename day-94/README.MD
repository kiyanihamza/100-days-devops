# Terraform Lab - Création d'un VPC AWS

## Objectif

Ce laboratoire Terraform permet de créer un VPC AWS nommé `xfusion-vpc` dans la région `us-east-1` avec un bloc CIDR IPv4 défini.

## Structure du projet

- [main.tf](main.tf) : contient la ressource Terraform pour créer le VPC.
- [provider.tf](provider.tf) : configure le provider AWS et la région cible.

## Configuration fournie

- Nom du VPC : `xfusion-vpc`
- Région : `us-east-1`
- CIDR : `10.0.0.0/16`

## Prérequis

Avant de lancer Terraform, assurez-vous d'avoir :

- Terraform installé sur votre machine
- Un accès configuré au provider AWS
- Le répertoire de travail correctement positionné sur ce projet

## Commandes utiles

Initialiser Terraform :

```bash
terraform init
```

Valider la configuration :

```bash
terraform validate
```

Afficher le plan d'exécution :

```bash
terraform plan
```

Appliquer la configuration :

```bash
terraform apply
```

## Notes

Ce lab est conçu pour démontrer la création d'une ressource réseau AWS avec Terraform de manière simple et claire.

