terraform {
  backend "s3" {
    bucket         = "fano-terraform-backend"
    key            = "dev/wordpress-ha-test.tfstate"
    region         = "eu-west-3"
    encrypt        = "true"
    dynamodb_table = "fano-terraform-backend"
  }
}
