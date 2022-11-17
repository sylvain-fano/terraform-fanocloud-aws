locals {
  credentials = {
    site_url       = var.app_url
    db_name        = var.db_name
    db_username    = data.aws_ssm_parameter.db_username.value
    db_password    = data.aws_ssm_parameter.db_password.value
    db_host        = var.db_host
    app_title      = var.app_title
    app_username   = var.app_admin_username
    app_password   = var.app_admin_password
    app_email      = var.app_admin_email
    file_system_id = var.app_fs_id
  }
}

resource "aws_launch_template" "this" {
  name          = "${var.project_prefix}-app_lt"
  description   = "Launch Template for the app instances"
  image_id      = data.aws_ami.amz_linux_2.id
  instance_type = var.instance_type
  key_name      = var.ec2_keypair_name
  user_data     = base64encode(templatefile("${path.module}/templates/bootstrap-wordpress.sh.tftpl", local.credentials))

  iam_instance_profile {
    name = aws_iam_instance_profile.parameter_store_profile.name
  }

  network_interfaces {
    security_groups = var.security_groups_ids
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        "Name" = "${var.project_prefix}-app_lt"
      }
    )
  }
}
