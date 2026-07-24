# Day 97 - Terraform IAM Policy for EC2 Read-Only Access

Cet exercice montre comment créer une politique IAM AWS avec Terraform pour qu’un utilisateur puisse voir les ressources EC2 dans la console AWS, sans pouvoir les modifier.

## Pourquoi on fait cela

Dans AWS, les permissions sont gérées par des politiques IAM. Si un utilisateur doit seulement consulter des instances EC2, des AMIs et des snapshots, il faut lui donner des permissions de lecture, et pas des permissions d’administration.

L’objectif de cette activité est d’apprendre :
- comment Terraform crée une politique IAM
- comment définir le provider AWS et la région
- pourquoi certaines actions EC2 sont nécessaires pour afficher les informations dans la console
- pourquoi une politique en lecture seule est plus sûre qu’une politique complète

## Ce que permet cette politique

Cette politique permet à l’utilisateur de voir dans la console :
- les instances EC2
- les AMIs
- les snapshots

Elle ne permet pas de démarrer, arrêter, créer, supprimer ou modifier des ressources EC2.

## Pourquoi ces permissions sont utilisées

Pour afficher des informations dans la console EC2, AWS a besoin d’actions de type lecture, par exemple :
- `ec2:Describe*` : permet de lister et décrire les ressources EC2
- `ec2:GetConsole*` : permet d’accéder aux fonctions liées à la console
- `ec2:List*` : permet de lister les ressources disponibles

Ces actions sont utilisées parce que la console doit d’abord demander des informations à AWS avant de les afficher à l’utilisateur.

## Pourquoi `Resource = "*"`

Dans IAM, `Resource = "*"` signifie que la politique s’applique à toutes les ressources concernées par ce service. Dans cet exemple, cela permet à l’utilisateur de consulter les ressources EC2 sans avoir à préciser chaque ressource une par une.

## Que signifie `Sid`

`Sid` signifie “Statement ID”. C’est un nom donné à une règle particulière dans la politique IAM. Il sert surtout à rendre la politique plus claire et plus facile à identifier, surtout si elle contient plusieurs règles.

Dans notre exemple, `Sid = "EC2ConsoleReadOnly"` signifie simplement que cette règle correspond à l’accès en lecture seule à la console EC2.

## Explication du fichier Terraform

Le fichier contient trois parties importantes :

1. La configuration du provider
   - on définit le provider AWS
   - on précise la région `us-east-1`
   - cela indique à Terraform dans quelle région AWS travailler

2. La ressource IAM policy
   - `aws_iam_policy` crée la politique dans AWS
   - le nom de cette politique sera `iampolicy_javed`

3. Le contenu de la politique
   - le bloc `policy` décrit les permissions accordées
   - `Effect = "Allow"` signifie que l’accès est autorisé
   - `Action` liste les actions autorisées
   - `Resource` précise sur quelles ressources la politique s’applique

## Comment utiliser ce fichier

1. Initialiser Terraform :
   ```bash
   terraform init
   ```

2. Voir les changements à appliquer :
   ```bash
   terraform plan
   ```

3. Appliquer la configuration :
   ```bash
   terraform apply
   ```

## Résumé d’apprentissage

Cet exemple montre un principe important en DevOps :
- l’infrastructure peut être créée avec du code
- les permissions doivent être données avec précision et sécurité
- un accès en lecture seule est suffisant quand l’utilisateur a seulement besoin de consulter les ressources
