data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "fano-terraform-backend"
    key    = "prod/services/terraform-aws-vpc-3tiers.tfstate"
    region = var.region
  }
}

