# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  required_version = "~>1.3.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.40.0"
    }
  }
}

provider "aws" {
  region = var.region
}
