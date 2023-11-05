include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars      = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  app_env_config = {
    env            = local.environment_vars.locals.env
    region         = local.common_vars.default.region
    project_prefix = local.environment_vars.locals.project_prefix
  }
}

terraform {
  source = "${local.environment_vars.locals.module_repo_root}/terraform-aws-efs"
}

dependency "vpc" {
  config_path = "../../../vpc"
}

inputs = merge(
  local.app_env_config,
  {
    vpc_context = dependency.vpc.outputs
  }
)