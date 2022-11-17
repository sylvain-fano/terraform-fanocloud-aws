data "aws_ssm_parameter" "db_username" {
  name = format("/%s/db/username", var.project_prefix)
}

data "aws_ssm_parameter" "db_password" {
  name = format("/%s/db/password", var.project_prefix)
}

data "aws_ami" "amz_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}