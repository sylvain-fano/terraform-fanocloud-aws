locals {
  credentials = {
    site_url       = aws_lb.app.dns_name
    db_name        = local.db.db_name
    db_username    = local.db.db_master_username
    db_password    = local.db.db_master_password
    db_host        = local.db.db_host
    app_title      = var.app_title
    admin_username = var.admin_username
    admin_password = var.admin_password
    admin_email    = var.admin_email
    file_system_id = local.efs.efs_id
  }
}

resource "aws_launch_template" "this" {
  name          = "${var.project_prefix}-app_lt"
  description   = "Launch Template for the app instances"
  image_id      = data.aws_ami.amz_linux_2.id
  instance_type = var.instance_type
  key_name      = var.ec2_keypair_name
  user_data     = base64encode(templatefile("${path.module}/files/bootstrap-wordpress.sh.tftpl", local.credentials))

  iam_instance_profile {
    name = aws_iam_instance_profile.parameter_store_profile.name
  }

  network_interfaces {
    security_groups = [aws_security_group.app.id]
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

resource "aws_autoscaling_group" "app" {
  name             = "${var.project_prefix}-app_asg"
  desired_capacity = var.asg_desired_capacity
  min_size         = var.asg_min_size
  max_size         = var.asg_max_size

  vpc_zone_identifier = local.vpc.app_subnets_ids
  target_group_arns   = [aws_lb_target_group.app.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}
