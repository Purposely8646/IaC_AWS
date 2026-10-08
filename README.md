# Importation d'un VPC AWS existant avec Terraform

## Contexte

Ce projet part d'une infrastructure AWS réelle, partiellement créée manuellement via la console ("ClickOps") :

- **AZ1** : entièrement configurée à la main (subnet public/privé, route tables, security groups, instances EC2, ALB)
- **AZ2** : partiellement présente (subnet + route table déjà créés), le reste manquant

**Objectif** : reprendre cette infrastructure existante dans Terraform sans la recréer, puis généraliser le code pour compléter automatiquement l'AZ2 et obtenir une architecture redondante multi-AZ.

## Méthodologie

### 1. Audit de l'infrastructure existante

Avant d'écrire la moindre ligne de code, l'ensemble des ressources a été inventorié via AWS CLI, organisé par service pour garantir l'exhaustivité :

- **Réseau** : VPC, Subnets, Route Tables, Internet Gateway, NAT Gateway
- **Sécurité** : Security Groups (avec analyse des règles imbriquées, y compris les références croisées SG↔SG)
- **Calcul** : Instances EC2, Key Pairs
- **Exposition** : Application Load Balancer, Target Group, Listener

Chaque ressource a été validée par recoupement avec l'API `resourcegroupstaggingapi`, pour s'assurer qu'aucune ressource taguée n'échappait à l'inventaire.

### 2. Import dans Terraform

Terraform étant un outil **déclaratif**, il ne peut pas "découvrir" une infrastructure existante par lui-même : son `state` (le fichier qui représente sa connaissance de l'infra) était vide au départ, malgré une infra AWS bien réelle.

La méthode utilisée pour faire converger `state` et réalité AWS, sans recréer aucune ressource :

```hcl
import {
  to = aws_vpc.main
  id = "vpc-xxxxxxxx"
}
```

Puis génération automatique du code HCL correspondant :

```bash
terraform plan -generate-config-out=generated.tf
terraform apply
```

Validation systématique par `terraform plan` → doit annoncer `No changes.` avant de passer à l'étape suivante.

### 3. Ressources "relationnelles" (point d'attention notable)

Certaines ressources AWS ne sont pas des objets autonomes mais des **relations entre deux ressources** (Route Table ↔ Subnet, Target Group ↔ Instance). Leur import nécessite un identifiant composite plutôt qu'un simple ID :

```hcl
import {
  to = aws_route_table_association.public_az1
  id = "subnet-xxxxxxxx/rtb-xxxxxxxx"
}
```

### 4. Généralisation par AZ *(prochaine étape)*

Une fois l'AZ1 fidèlement capturée, le code sera généralisé via `for_each` afin qu'un seul bloc de ressources s'applique aux deux AZ, en distinguant :

- **Ressources partagées** (VPC, IGW, ALB, Security Groups, Key Pair) → bloc unique
- **Ressources par-AZ** (Subnet, Route Table, Instance) → pilotées par une variable `map`

### 5. Complétion de l'AZ2 *(prochaine étape)*

`terraform plan` devra alors distinguer automatiquement :
- `No changes` pour ce qui existe déjà des deux côtés (Subnet, Route Table de l'AZ2)
- `+ create` uniquement pour ce qui manque (Security Group, Instance, rattachement ALB de l'AZ2)

## Structure du projet

```
.
├── main.tf         # Provider AWS et configuration Terraform
├── variables.tf    # Déclaration de toutes les variables (IDs des ressources existantes)
├── Import.tf       # Blocs d'import de l'infrastructure existante
├── generated.tf    # Code généré automatiquement par Terraform (à fusionner)
└── README.md
```

## Ressources couvertes par l'import

| Catégorie | Ressources |
|---|---|
| Réseau | 1 VPC, 4 Subnets (2 publics, 2 privés), 5 Route Tables, 4 Route Table Associations, 1 Internet Gateway, 1 NAT Gateway |
| Sécurité | 4 Security Groups (NAT, Web, ALB, Bastion) |
| Calcul | 2 Instances EC2 (Bastion, Web), 2 Key Pairs |
| Exposition | 1 Application Load Balancer, 1 Listener, 1 Target Group, 1 Target Group Attachment |
| Adressage | 4 Elastic IP |

## Compétences mises en pratique

- **AWS CLI** : extraction de données structurées avec JMESPath (filtres, projections, jointures)
- **Terraform** : modèle déclaratif, distinction Code/State/Réel, mécanisme d'import natif (blocs `import`, `generate-config-out`)
- **Réseau AWS** : architecture VPC multi-AZ, distinction subnet public/privé, rôle de l'IGW et de la NAT Gateway
- **Sécurité** : analyse des Security Groups et de leurs règles croisées (accès restreint via `UserIdGroupPairs` plutôt que CIDR ouvert)
- **Git** : gestion de version du code d'infrastructure

## Prochaines étapes

- [ ] Résoudre la configuration des credentials AWS en local
- [ ] Exécuter `terraform apply` pour finaliser l'import
- [ ] Valider par `terraform plan` → `No changes.`
- [ ] Généraliser le code via `for_each`
- [ ] Créer les ressources manquantes de l'AZ2
- [ ] Valider la redondance multi-AZ (health check ALB sur les deux instances)
