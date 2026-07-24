# Terraform AWS Infrastructure - VPC, Subnet et EC2

## Contexte du besoin

Le but de cette activité était de créer une infrastructure AWS avec Terraform en respectant un ensemble de contraintes précises. L’objectif n’était pas seulement de créer des ressources, mais aussi de les organiser correctement pour qu’elles soient cohérentes entre elles au niveau du réseau, de la sécurité et de l’accès.

### Exigences demandées

1. Créer un VPC nommé `xfusion-priv-vpc` avec le bloc CIDR `10.0.0.0/16`.
2. Créer un subnet nommé `xfusion-priv-subnet` dans ce VPC avec le bloc CIDR `10.0.1.0/24`.
3. Désactiver l’attribution automatique d’adresse IP publique sur ce subnet, afin que l’instance EC2 reste privée.
4. Créer une instance EC2 nommée `xfusion-priv-ec2` dans ce subnet, de type `t2.micro`.
5. Configurer le security group pour autoriser les accès uniquement depuis le CIDR du VPC, afin de limiter l’exposition réseau.
6. Utiliser un fichier `main.tf` pour contenir la logique de provisionnement principal.
7. Définir les variables `KKE_VPC_CIDR` et `KKE_SUBNET_CIDR` dans un fichier `variables.tf`.
8. Exposer les sorties attendues dans un fichier `outputs.tf` : `KKE_vpc_name`, `KKE_subnet_name` et `KKE_ec2_private`.

## Ce qui a été fait

La configuration Terraform a été écrite pour répondre à chaque exigence de manière structurée.

### 1. Création du VPC

Le VPC a été défini avec le bloc CIDR demandé, soit `10.0.0.0/16`. Cette plage réseau sert de base à toute l’architecture interne. Elle permet de regrouper les ressources réseau dans un espace logique isolé.

### 2. Création du subnet

Un subnet a ensuite été créé dans ce VPC avec le bloc CIDR `10.0.1.0/24`. Ce subnet est pensé comme une zone réseau dédiée à l’instance EC2. L’option `map_public_ip_on_launch = false` a été activée pour éviter que l’instance reçoive une adresse IP publique automatique.

### 3. Création de l’instance EC2

L’instance EC2 a été créée dans ce subnet avec le type `t2.micro`, ce qui correspond à une instance légère et adaptée à un usage basique. Elle est placée dans le subnet privé et associée à un security group spécifique.

### 4. Configuration du security group

Un security group a été ajouté pour contrôler le trafic réseau. La règle d’entrée a été définie de sorte à autoriser uniquement les connexions en provenance du CIDR du VPC. Cela signifie que l’instance n’est pas accessible depuis Internet directement, mais seulement depuis d’autres ressources internes du réseau privé.

### 5. Utilisation des variables

Les variables demandées ont été déclarées dans `variables.tf` afin de rendre la configuration modulaire et facilement configurable. Cela permet de changer les blocs CIDR sans devoir modifier directement la logique du provisionnement.

### 6. Définition des sorties

Les sorties ont été ajoutées dans `outputs.tf` pour exposer les valeurs importantes après l’application de la configuration. Cela facilite l’identification et la vérification des ressources créées.

## Explication du rôle de chaque fichier

- `main.tf` : contient la définition de toutes les ressources principales : VPC, subnet, security group et instance EC2.
- `variables.tf` : centralise les valeurs configurables, notamment les CIDR du VPC et du subnet.
- `outputs.tf` : permet d’afficher les noms des ressources créées après l’exécution de Terraform.

## Résultat attendu

À l’issue de l’application de cette configuration, on obtient une architecture AWS minimale et cohérente composée de :

- un VPC privé nommé `xfusion-priv-vpc` ;
- un subnet privé nommé `xfusion-priv-subnet` ;
- une instance EC2 nommée `xfusion-priv-ec2` ;
- un security group limitant l’accès au réseau interne du VPC.

## En résumé

Ce projet a permis de répondre au besoin demandé en construisant une infrastructure Terraform simple, sécurisée et adaptée à un environnement privé. La solution respecte les noms attendus, les blocs CIDR requis, le type d’instance demandé et le principe de restriction d’accès au réseau interne.
