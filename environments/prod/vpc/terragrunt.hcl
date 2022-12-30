include "root" {
  path = find_in_parent_folders()
}

locals {
  common_vars      = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  app_env_config = {
    env        = local.environment_vars.locals.env
    region     = local.common_vars.default.region
    azs            = ["eu-west-3a", "eu-west-3b"]
    project_prefix = "FanoCloud"
    cidr_block     = "10.16.0.0/16"
    public_subnets_cidr = ["10.16.10.0/24", "10.16.11.0/24"]
    private_subnets_cidr =  ["10.16.10.0/24", "10.16.11.0/24"]
    database_subnets_cidr =  ["10.16.20.0/24", "10.16.21.0/24"]
    # tags = local.common_vars.default.tags
    mgmt_networks = local.common_vars.default.mgmt_networks
    bastion_asg_desired_capacity = 1
    bastion_asg_min_size = 1
    bastion_asg_max_size = 1
    bastion_instance_type = "t3.micro"
  }
}

terraform {
  source = "${local.environment_vars.locals.module_repo_root}/terraform-aws-vpc"
}

dependency "keypair" {
  config_path = "../shared/keypair"
}

inputs =  merge(
  local.app_env_config,
  {
    ec2_keypair_name = dependency.keypair.kp_name
  }
)
