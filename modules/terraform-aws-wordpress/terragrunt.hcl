include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars      = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  app_env_config = {
    env        = local.environment_vars.locals.env
    region     = local.common_vars.default.region
    project_prefix = local.environment_vars.locals.project_prefix
    instance_type = "t3.small"
    app_title = local.environment_vars.locals.app_title
    ec2_keypair_name = local.common_vars.default.ec2_keypair_name
  }
}

dependency "vpc" {
  config_path = "../../../network/terraform-aws-vpc"
}

dependency "rds" {
  config_path = "../databases/terraform-aws-rds"
}

dependency "efs" {
  config_path = "../datastores/terraform-aws-efs"
}

inputs =  merge(
  local.app_env_config,
  {
    vpc_context = dependency.vpc.outputs
    rds_context = dependency.rds.outputs
    efs_context = dependency.efs.outputs
  }
)