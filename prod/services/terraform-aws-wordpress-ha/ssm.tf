resource "random_string" "app_username" {
  length  = 12
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "app_password" {
  length           = 24
  special          = true
  override_special = "!#$%^*()-=+_?{}|"
}

resource "random_string" "db_username" {
  length  = 12
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "db_password" {
  length           = 24
  special          = true
  override_special = "!#$%^*()-=+_?{}|"
}

# resource "aws_ssm_parameter" "app_title" {
#   name        = format("/%s/app/title", local.project_prefix)
#   description = "App website title"
#   type        = "String"
#   value       = local.app_title
# }

resource "aws_ssm_parameter" "app_username" {
  name        = format("/%s/app/username", local.project_prefix)
  description = "App Admin username"
  type        = "String"
  value       = random_string.app_username.result
}

resource "aws_ssm_parameter" "app_password" {
  name        = format("/%s/app/password", local.project_prefix)
  description = "App Admin password"
  type        = "SecureString"
  value       = random_password.app_password.result
}

# resource "aws_ssm_parameter" "app_email" {
#   name        = format("/%s/app/email", local.project_prefix)
#   description = "App Admin email"
#   type        = "String"
#   value       = local.app_admin_email
# }

# resource "aws_ssm_parameter" "db_host" {
#   name        = format("/%s/db/host", local.project_prefix)
#   description = "Database host for app"
#   type        = "String"
#   value       = module.wordpress_db_serverless.db_host
# }

resource "aws_ssm_parameter" "db_username" {
  name        = format("/%s/db/username", local.project_prefix)
  description = "Database username to be created in $db_name database"
  type        = "String"
  value       = random_string.db_username.result
}

resource "aws_ssm_parameter" "db_password" {
  name        = format("/%s/db/password", local.project_prefix)
  description = "Database password for $db_username"
  type        = "SecureString"
  value       = random_password.db_password.result
}

# resource "aws_ssm_parameter" "site_url" {
#   name        = format("/%s/app/url", local.project_prefix)
#   description = "App site url"
#   type        = "String"
#   value       = "http://${module.wordpress-cluster-ha.alb_dns}"
# }
