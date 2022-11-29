terraform {
  backend "s3" {
    bucket         = "fano-terraform-backend"
    key            = "prod/services/terraform-aws-vpc-3tiers.tfstate"
    region         = "eu-west-3"
    encrypt        = "true"
    dynamodb_table = "fano-terraform-backend"
  }
}
