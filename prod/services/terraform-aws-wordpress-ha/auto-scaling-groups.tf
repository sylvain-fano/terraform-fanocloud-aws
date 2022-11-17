resource "aws_autoscaling_group" "app" {
  name             = "${var.project_prefix}-app_asg"
  desired_capacity = var.app_asg_desired_capacity
  min_size         = var.app_asg_min_size
  max_size         = var.app_asg_max_size

  vpc_zone_identifier = aws_subnet.app[*].id
  target_group_arns   = [aws_lb_target_group.app.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = var.app_launch_template_id
    version = "$Latest"
  }
}
