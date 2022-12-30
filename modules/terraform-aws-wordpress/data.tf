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

locals {
  vpc = var.vpc_context
  db  = var.db_context
  efs = var.efs_context
}