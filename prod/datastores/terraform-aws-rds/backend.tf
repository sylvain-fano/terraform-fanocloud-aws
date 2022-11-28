terraform {
  backend "s3" {
    bucket         = "fano-terraform-backend"
    key            = "prod/datastores/terraform-aws-rds.tfstate"
    region         = "eu-west-3"
    encrypt        = "true"
    dynamodb_table = "fano-terraform-backend"
  }
}
