terraform {
  #Décrire le fournisseur cloud (dans notre cas AWS)
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.58.0"
    }
  }
  #Version minimum de Teraform pour éxécuter le script
  required_version = ">= 1.15"
}

provider "aws" {
  region = "eu-west-3"
  profile = "${var.profile}"
}