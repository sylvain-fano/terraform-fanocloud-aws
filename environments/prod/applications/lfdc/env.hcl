locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  env            = local.environment_vars.locals.env
  module_repo_root = local.environment_vars.locals.module_repo_root
  project_prefix = "lfdc"
  app_title      = "La Fabrique des Copains 2.0"

}
