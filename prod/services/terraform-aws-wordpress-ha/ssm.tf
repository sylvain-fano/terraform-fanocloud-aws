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

resource "aws_ssm_parameter" "app_title" {
  name        = format("/%s/app/title", var.project_prefix)
  description = "App website title"
  type        = "String"
  value       = var.app_title
}

resource "aws_ssm_parameter" "app_username" {
  name        = format("/%s/app/username", var.project_prefix)
  description = "App Admin username"
  type        = "String"
  value       = random_string.app_username.result
}

resource "aws_ssm_parameter" "app_password" {
  name        = format("/%s/app/password", var.project_prefix)
  description = "App Admin password"
  type        = "SecureString"
  value       = random_password.app_password.result
}

resource "aws_ssm_parameter" "admin_email" {
  name        = format("/%s/app/admin_email", var.project_prefix)
  description = "App Admin email"
  type        = "String"
  value       = var.admin_email
}

resource "aws_ssm_parameter" "app_url" {
  name        = format("/%s/app/url", var.project_prefix)
  description = "App site url"
  type        = "String"
  value       = "http://${aws_lb.app.dns_name}"
}
