locals {
  project_name     = "Wordpess-HA"
  env              = "dev"
  project_prefix   = "${local.project_name}-${local.env}"
  ec2_keypair_name = "terraform-kp"
  ec2_keypair_path = "~/.ssh/id_rsa.pub"
  region           = "eu-west-3"
  azs              = ["eu-west-3a", "eu-west-3b"]
  tags = {
    "Terraform" = "true"
    "Project"   = local.project_name
    "Env"       = local.env
  }
}

module "memcached_cluster" {
  source              = "./modules/services/terraform-aws-elasticache"
  subnets_ids         = module.wordpress_cluster_ha.db_subnets_ids
  security_groups_ids = module.wordpress_cluster_ha.db_security_groups_ids
  project_prefix      = local.project_prefix
  env                 = local.env
  tags                = local.tags
  cluster_identifier  = "fano-cluster-test"
  node_type           = "cache.t4g.micro"
  nodes_count         = 2
}

# module "wordpress_efs" {
#   source         = "./modules/services/terraform-aws-efs"
#   project_prefix = local.project_prefix
#   env            = local.env
#   tags           = local.tags
# }

module "wordpress_efs" {
  source           = "terraform-aws-modules/efs/aws"
  creation_token   = local.project_prefix
  encrypted        = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  lifecycle_policy = {
    transition_to_ia = "AFTER_30_DAYS"
  }

  create_security_group = false
  mount_targets = {

    "eu-west-3a" = {
      subnet_id = module.wordpress_cluster_ha.app_subnets_ids[0]
    }

    "eu-west-3b" = {
      subnet_id = module.wordpress_cluster_ha.app_subnets_ids[1]
    }
  }

  tags = merge(
    local.tags,
    {
      "Name" = "${local.project_prefix}-app_fs"
    }
  )
}

module "vpc" {
  source                       = "./modules/services/terraform-aws-vpc-3tiers"
  region                       = local.region
  azs                          = local.azs
  project_prefix               = local.project_prefix
  env                          = local.env
  cidr_block                   = "10.16.0.0/16"
  mgmt_networks                = var.mgmt_networks
  ec2_keypair_name             = local.ec2_keypair_name
  bastion_asg_desired_capacity = 1
  bastion_asg_min_size         = 1
  bastion_asg_max_size         = 1
  bastion_launch_template_id   = module.bastion_launch_template.launch_template_id
  tags                         = local.tags
}

module "wordpress_ha" {
  source                    = "./modules/services/terraform-aws-wordpress-ha"
  project_prefix            = local.project_prefix
  env                       = local.env
  ec2_keypair_name          = local.ec2_keypair_name
  app_asg_desired_capacity  = 2
  app_asg_min_size          = 2
  app_asg_max_size          = 2
  app_fs_id                 = module.wordpress_efs.id
  app_launch_template_id    = module.wordpress_launch_template.launch_template_id
  tags                      = local.tags
  vpc_id                    = module.vpc.vpc_id
  bastion_security_group_id = module.vpc.bastion_security_groups_ids
}

module "wordpress_db_serverless" {
  source              = "./modules/services/terraform-aws-rds"
  project_prefix      = local.project_prefix
  env                 = local.env
  cluster_identifier  = "fano-cluster-test"
  database_name       = "wordpressDev"
  min_capacity        = 1
  max_capacity        = 2
  tags                = local.tags
  security_groups_ids = module.wordpress_cluster_ha.db_security_groups_ids
  subnets_ids         = module.wordpress_cluster_ha.db_subnets_ids

  depends_on = [
    aws_ssm_parameter.db_username,
    aws_ssm_parameter.db_password
  ]
}

module "wordpress_launch_template" {
  source              = "./modules/launch-templates/terraform-aws-launch-template-wordpress"
  project_prefix      = local.project_prefix
  env                 = local.env
  tags                = local.tags
  app_url             = module.wordpress_cluster_ha.alb_dns
  app_title           = "My Super Cool Website"
  app_admin_email     = "sylvain@fano.me"
  ec2_keypair_name    = local.ec2_keypair_name
  instance_type       = "t3.micro"
  security_groups_ids = module.wordpress_cluster_ha.app_security_groups_ids
  app_fs_id           = module.wordpress_efs.id
  db_name             = module.wordpress_db_serverless.db_name
  db_host             = module.wordpress_db_serverless.db_host

  depends_on = [
    aws_ssm_parameter.db_username,
    aws_ssm_parameter.db_password
  ]
}

module "bastion_launch_template" {
  source              = "./modules/launch-templates/terraform-aws-launch-template-bastion"
  project_prefix      = local.project_prefix
  env                 = local.env
  tags                = local.tags
  ec2_keypair_name    = local.ec2_keypair_name
  instance_type       = "t3.micro"
  security_groups_ids = module.wordpress_cluster_ha.bastion_security_groups_ids
}

# resource "aws_instance" "test" {
#   ami                         = "ami-02b01316e6e3496d9"
#   tags                        = { "Name" = "test" }
#   # subnet_id                   = module.wordpress_cluster_ha.public_subnets_ids[0]
#   associate_public_ip_address = true

#   user_data     = base64encode(templatefile("${path.module}/scripts/bootstrap-wordpress.tpl.sh", local.credentials))
#   key_name      = local.ec2_keypair_name
#   instance_type = "t3.micro"
# }

# locals {
#   credentials = {
#     site_url       = "url"
#     db_name        = "dbname"
#     db_username    = "admin"
#     db_password    = "password"
#     db_host        = "host"
#     app_title      = "mon app"
#     app_username   = "admin"
#     app_password   = "password"
#     app_email      = "sylvain@fano.me"
#     file_system_id = module.wordpress_efs.efs_id
#   }
# }
