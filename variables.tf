variable "region" {
    description = "region fournisseur" 
    default = "eu-west-3"
}

variable "profile" {
  description = "nom de l'utilisateur SSO"
}

variable "aws_vpc" {
  type = string
  description = "ID du VPC developpement-vpc "
  default = "vpc-0eeac0a964c9d3a53"
}

# varaibles des sous réseaux du vpc (vérifié)
variable "public_subnet1" {
  type = string
  description = "identifiant du sous-réseau publique de l'AZ1"
  default = "subnet-080a8171d01ad5452"
}

variable "public_subnet2" {
  type = string
  description = "identifiant du sous-réseau publique de l'AZ2"
  default = "subnet-0e19e8030d9943193"
}

variable "private_subnet1" {
  type = string
  description = "identifiant du sous-réseau privé de l'AZ1"
  default = "subnet-044540ec65a3a2ccf"
}

variable "private_subnet2" {
  type = string
  description = "identifiant du sous-réseau privé de l'AZ2"
  default = "subnet-000a21389d8894b0c"
}

# Tables de routage (vérifié)
variable "routetable1" {
  type = string
  description = "value"
  default = "rtb-0f6537ed4a24c9c49"
}

variable "routetable2" {
  type = string
  description = "value"
  default = "rtb-08c52a7c4ebe371a4"
}

variable "routetable3" {
  type = string
  description = "value"
  default = "rtb-049b35a1d8153795b"
}

variable "routetable4" {
  type = string
  description = "value"
  default = "rtb-033d7570c95b83367"
}

variable "routetable5" {
  type = string
  description = "value"
  default = "rtb-0ca4679dabb0aadbf"
}

# Variable ID Association Table
variable "asso_public1" {
  type = string
  description = "réseau public1 (asso1)"
  default = "subnet-080a8171d01ad5452/rtb-0f6537ed4a24c9c49" 
}

variable "asso_public2" {
  type = string
  description = "rtb-assoc réseau public 2"
  default = "subnet-0e19e8030d9943193/rtb-0f6537ed4a24c9c49"
}

variable "asso_private1" {
  type = string
  description = "rtb-assoc réseau privé 1 (asso3)"
  default = "subnet-044540ec65a3a2ccf/rtb-08c52a7c4ebe371a4"
}

variable "asso_private2" {
  type = string
  description = "rtb-assoc réseau privé 2 (asso4)"
  default = "subnet-000a21389d8894b0c/rtb-049b35a1d8153795b"
}

variable "asso_nat" {
  type = string
  description = "table d'association de table de routage reliant la NAT gateway (asso5)"
  default = "nat-12f7447905f7d3daf/rtb-033d7570c95b83367"
}


# Variables de l'ALB

variable "ALB_ARN" {
  type = string
  description = "id de l'ALB"
  default = "arn:aws:elasticloadbalancing:eu-west-3:233231935533:loadbalancer/app/ALB/4c1cbebdff5cb4a0"
}

variable "ALB_TargetGroup" {
  type = string
  description = "ID des Listeners"
  default = "arn:aws:elasticloadbalancing:eu-west-3:233231935533:targetgroup/TG-WEB-PRIVATE/2bee848b0966f236"
}

variable "ALB_Listeners" {
  type = string
  description = "value"
  default = "arn:aws:elasticloadbalancing:eu-west-3:233231935533:listener/app/ALB/4c1cbebdff5cb4a0/cf673a7ca9e0691f"
}

variable "Bastion_ID" {
  type = string
  description = "identifiant de la VM NAT Instance"
  default = "i-089b58afc2e1e16e1"
}

variable "Web_ID" {
  type = string
  description = "id du serveur web nginx"
  default = "i-064e594cf644d1b8b"
}

variable "sg-web" {
  type = string
  description = "value"
  default = "sg-02b149c84d30bf38f"
}

variable "sg-nat" {
  type = string
  description = "value"
  default = "sg-0058dc61b057c95b2"
}

variable "SG-ALB" {
  type = string
  description = "value"
  default = "sg-0a16ebdd5b719dc9c"
}

variable "SG-Bastion" {
  type = string
  description = "value"
  default = "sg-05a65c447217cfd37"
}

variable "Internet" {
  type = string
  description = "id de la passerelle internet"
  default = "igw-0b79b2ccb8be871a7"
}

variable "nat-gtw" {
  type = string
  description = "ID de la NAT gateway"
  default = "nat-12f7447905f7d3daf"
}

# Variables de l'Elastic IP (location d'IP publique)
variable "elastic-nat1" {
  type = string
  description = "ID d'allocation EIP de la NAT"
  default = "eipalloc-0dabaed0cdbf1463c"
}

variable "elastic-nat2" {
  type = string
  description = "ID d'allocation EIP de la NAT"
  default = "eipalloc-0c66fef6234e140da"
}

variable "elastic-ALB" {
  type = string
  description = "ID de d'allocation EIP de l'ALB"
  default = "eipalloc-00eec6861cab37eda"
}

variable "elastic-bastion" {
  type = string
  description = "ID d'allocation EIP du Bastion"
  default = "eipalloc-037c0e8dc321ed489"
}

# paires de clé des VMs

variable "key_web" {
  type = string
  description = "clé SSH pour se connecter au serveur web"
  default = "srv-web"
}

variable "key_bastion" {
  type = string
  description = "clé SSH pour se connecter au bastion"
  default = "Iencli"
}

# Adresse privé de l'amdin pour se connecter au bastion à l'extérieur

variable "IP_admin" {
  type = string
  description = "adresse IP de l'admin pour se connecter en SSH depuis l'éxtérieur"
}