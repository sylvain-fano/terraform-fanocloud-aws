data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "fano-terraform-backend"
    key    = "prod/services/terraform-aws-vpc.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "fano-terraform-backend"
    key    = "prod/datastores/terraform-aws-rds.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "efs" {
  backend = "s3"

  config = {
    bucket = "fano-terraform-backend"
    key    = "prod/services/terraform-aws-efs.tfstate"
    region = var.region
  }
}

data "aws_ami" "amz_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

locals {
  vpc = data.terraform_remote_state.vpc.outputs
  db  = data.terraform_remote_state.db.outputs
  efs = data.terraform_remote_state.efs.outputs
}