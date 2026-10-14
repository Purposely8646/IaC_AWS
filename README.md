# Industrialisation d'un VPC AWS existant avec Terraform

> **Statut : projet archivé.** Projet réalisé à l'été 2026. L'infrastructure a depuis été **détruite pour des raisons de budget** (`terraform destroy`, puis nettoyage restant via la console AWS). Ce dépôt documente la démarche et le code produit : il n'est pas conçu pour être rejoué tel quel (voir [Limites connues](#limites-connues)).

## Contexte

Le projet part d'une infrastructure AWS réelle (région `eu-west-3`), créée manuellement via la console ("ClickOps") :

- **AZ1** : entièrement configurée à la main (subnets public/privé, route tables, security groups, instances EC2, ALB)
- **AZ2** : partiellement présente (subnets et route tables), sans instance

**Objectif** : reprendre cette infrastructure dans Terraform sans la recréer, en passant par l'import des ressources existantes.

## Architecture

- 1 VPC, 4 subnets (public/privé dans chacune des 2 AZ), Internet Gateway, NAT Gateway
- 1 Application Load Balancer (HTTP) devant un Target Group qui cible le serveur web
- 1 serveur web (nginx) en subnet privé, 1 instance bastion pour l'accès SSH
- 4 Security Groups avec règles croisées (SG ↔ SG) plutôt que CIDR ouvert

```
Internet ──► ALB (subnets publics) ──► serveur web (privé) ──► NAT Gateway ──► Internet
```

## Méthodologie

### 1. Audit de l'infrastructure existante

Inventaire complet via AWS CLI (réseau, sécurité, calcul, exposition), recoupé avec l'API `resourcegroupstaggingapi` pour s'assurer qu'aucune ressource taguée n'échappait à l'inventaire.

### 2. Import dans Terraform

Terraform est déclaratif : son `state` était vide alors que l'infrastructure existait. Un bloc `import` associe l'**ID réel** d'un objet AWS à une **adresse** du code, et enregistre cette correspondance dans le state :

```hcl
import {
  to = aws_vpc.name
  id = "vpc-xxxxxxxx"
}
```

Le brouillon du code HCL a ensuite été généré à partir des objets importés :

```bash
terraform plan -generate-config-out=generated.tf
```

### 3. Ressources "relationnelles"

Certaines ressources sont des relations entre deux objets (Route Table ↔ Subnet). Leur import demande un identifiant composite :

```hcl
import {
  to = aws_route_table_association.asso3
  id = "subnet-xxxxxxxx/rtb-xxxxxxxx"
}
```

### 4. Validation

Après correction du code, `terraform plan` devait annoncer `No changes` pour prouver que le code décrit fidèlement l'infrastructure existante.

## Évolution du code

| Version | Contenu | Validation |
|---|---|---|
| 1. Code généré | ~800 lignes produites par `-generate-config-out` | Non exploitable tel quel |
| 2. Code corrigé | Relecture bloc par bloc, IDs réels conservés | `plan` : No changes, premier `apply` en échec |
| 3. Refonte | Réécriture après les erreurs du premier `apply` | Second `apply` réussi, dernier `plan` : **No changes** |
| 4. Références | IDs remplacés par des adresses entre ressources, code complété pour couvrir toute l'infra | `terraform validate` : succès |
| 5. Règles séparées | Règles de l'ALB sorties du Security Group pour casser un cycle de dépendances | `terraform validate` : succès |

Les versions 4 et 5 n'ont pas été rejouées par un `apply` sur AWS : l'infrastructure avait alors été détruite.

## Difficultés rencontrées

### Configuration générée imparfaite

`-generate-config-out` a produit un fichier d'environ 800 lignes, mais le code généré n'était ni syntaxiquement propre ni directement exploitable. Une correction manuelle a été nécessaire sur la quasi-totalité des blocs :

- auto-références (une ressource pointant vers son propre attribut)
- arguments générés mais invalides pour le type de ressource
- IDs bruts à convertir en références
- types mal formés (liste attendue au lieu d'une valeur seule, objet fourni à la place de `.id`, CIDR sans masque)

### Un `plan` correct n'a pas suffi à garantir un `apply` réussi

Le premier `apply` a échoué avec une nouvelle série d'erreurs que le `plan` n'avait pas signalées : arguments réclamés alors qu'ils figuraient dans le code (les `null` écrits par le générateur sont traités comme des arguments absents) et arguments rejetés comme invalides ou inexistants. Le provider utilisé (`hashicorp/aws` v6.58.0) est celui qui a généré le code : ces erreurs viennent donc plus probablement de la façon dont le générateur écrit la configuration (attributs en lecture seule, combinaisons d'arguments incompatibles, `null` explicites) que d'un décalage de version. Une refonte du code a été nécessaire avant qu'un second `apply` aboutisse.

### Une adresse valide n'est pas forcément la bonne

En remplaçant les IDs par des références, une règle de sortie de `sg_alb` s'est retrouvée à pointer vers `sg_alb` lui-même au lieu de `sg_web`. `terraform validate` ne signale pas ce genre d'erreur : il contrôle la forme du code, pas son sens. L'erreur a été repérée en relisant le fonctionnement attendu (l'ALB reçoit d'internet et envoie au serveur web), puis confirmée en comparant avec l'ancien state.

### Dépendance circulaire entre Security Groups

Une fois la cible corrigée, `sg_alb` et `sg_web` se référençaient mutuellement dans leurs règles intégrées. Terraform détecte la boucle avant toute création (`Error: Cycle`). La solution a été de sortir les règles de `sg_alb` dans des ressources séparées (`aws_vpc_security_group_ingress_rule` et `aws_vpc_security_group_egress_rule`) : le groupe est créé vide, puis `sg_web`, puis les règles qui citent les deux. Un nom de ressource approximatif (`aws_security_group_ingress_rule`) est rejeté par `validate`, et les arguments diffèrent de l'ancien format (`cidr_ipv4` au lieu de `cidr_blocks`, `referenced_security_group_id` au lieu de `security_groups`).

### Limite assumée

La correction a été menée de façon empirique (test, observation, ajustement). Certaines causes racines côté provider ne sont comprises que partiellement.

## Gestion des données sensibles

| Fichier | Contenu | Publié |
|---|---|---|
| `*.tf` | Code et déclaration des variables | Oui |
| `variables.tfvars` | Valeurs sensibles (IP d'administration) | **Non** (`.gitignore`) |
| `*.tfstate`, `.terraform/` | État de l'infra (contient tout en clair) | **Non** (`.gitignore`) |

La variable `IP_admin` n'a pas de valeur par défaut : elle est fournie uniquement par le fichier de valeurs local (`terraform plan -var-file=variables.tfvars`). Les IDs historiques conservés dans `variables.tf` ne sont pas des secrets : ils désignent des objets qui n'existent plus.

L'état Terraform a été sauvegardé avant la destruction comme référence de ce qui existait, mais il n'est pas dans le dépôt.

## Ressources couvertes

| Catégorie | Ressources |
|---|---|
| Réseau | 1 VPC, 4 Subnets, 5 Route Tables, 5 Route Table Associations + 1 association de table principale, 1 Internet Gateway, 1 NAT Gateway |
| Sécurité | 4 Security Groups (NAT, Web, ALB, Bastion), dont les règles de l'ALB déclarées séparément |
| Calcul | 2 instances EC2 (Bastion, Web) ; les key pairs sont référencées par leur nom, non gérées |
| Exposition | 1 ALB, 1 Listener, 1 Target Group, 1 Target Group Attachment |
| Adressage | 4 Elastic IP |

## Structure du projet

```
.
├── main.tf         # Provider AWS et configuration Terraform
├── variables.tf    # Déclaration de toutes les variables (IDs des ressources existantes)
├── Import.tf       # Blocs d'import de l'infrastructure existante (historique)
├── generated.tf    # Toutes les ressources : code généré puis corrigé et complété à la main
└── README.md
```

## Avancement

- [x] Audit et inventaire de l'infrastructure existante
- [x] Import des ressources existantes (AZ1 et éléments déjà présents en AZ2)
- [x] Correction manuelle du code généré
- [x] Premier `apply` en échec, refonte, second `apply` réussi, `plan` final : No changes
- [x] Remplacement des identifiants par des références entre ressources
- [x] Résolution d'une dépendance circulaire entre Security Groups
- [x] Destruction de l'infrastructure (contrainte budgétaire)
- [ ] ~~Généralisation par `for_each`~~ : abandonné, infrastructure détruite avant cette étape
- [ ] ~~Complétion de l'AZ2~~ : idem

## Limites connues

- **Dépôt non rejouable tel quel** : l'infrastructure d'origine n'existe plus, et `Import.tf` pointe vers des objets détruits. Ses blocs doivent être retirés avant tout nouvel `apply`.
- Les versions 4 et 5 du code (références, règles séparées) sont validées par `terraform validate` mais n'ont pas été rejouées contre AWS.
- Les interfaces réseau des instances sont référencées par des IDs historiques, sans ressource `aws_network_interface` correspondante.
- Les CIDR IPv6 des subnets sont ceux attribués par AWS à l'époque, non dérivés du VPC.
- Les règles intégrées de `sg_web` et les règles séparées de `sg_alb` coexistent : le choix de séparer `sg_alb` a été fait pour casser le cycle, sans uniformiser le reste.

## Compétences mises en pratique

- **AWS CLI** : extraction structurée avec JMESPath, inventaire par service
- **Terraform** : modèle déclaratif, distinction code / state / réel, import natif et génération de configuration, graphe de dépendances et résolution de cycle
- **Revue de code généré** : repérage et correction d'erreurs de syntaxe, de schéma et de dépendances sur ~800 lignes
- **Réseau AWS** : VPC multi-AZ, subnets publics/privés, IGW, NAT, ALB
- **Sécurité** : Security Groups à règles croisées, séparation code / valeurs sensibles, `.gitignore`
- **Git** : gestion de version du code d'infrastructure