data "aws_ssm_parameter" "db_username" {
  name = format("/%s/db/username", var.project_prefix)
}

data "aws_ssm_parameter" "db_password" {
  name = format("/%s/db/password", var.project_prefix)
}
