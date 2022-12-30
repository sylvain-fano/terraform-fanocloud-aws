locals {
  # Automatically load common variables for all projects
  # common_vars = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
  common_vars = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  aws_region  = local.common_vars.default.region
  env         = local.environment_vars.locals.env
  aws_provider_tags = {
    "Terraform" = "true"  
    "Environment" = local.env  
    "TerragruntPath" = path_relative_to_include()
    # "ProductName" = local.productName
  }
}

# Configure Terragrunt to create backend.tf if it doesn't exist and automatically store tfstate files in an S3 bucket
remote_state {
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  backend = "s3"
  config = {
    bucket         = "fano-terraform-backend"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }  
}

# Generate provider.tf file it if doesn't already exist
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
   contents = templatefile("provider.tmpl", {
    aws_provider_tags        = local.aws_provider_tags
    aws_region               = local.aws_region
  })
}
