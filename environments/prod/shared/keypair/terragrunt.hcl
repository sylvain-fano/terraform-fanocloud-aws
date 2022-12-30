include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars      = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))

  app_env_config = {
    region     = local.common_vars.default.region
    keypair_name = local.common_vars.default.ec2_keypair_name
  }
}

terraform {
  source = "${local.environment_vars.locals.module_repo_root}/terraform-aws-keypair"
}

inputs = merge(local.app_env_config)
  