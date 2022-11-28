resource "aws_lb" "app" {
  name                       = "app-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = local.vpc.public_subnets_ids
  enable_deletion_protection = false
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-app_alb"
    }
  )
}

resource "aws_lb_target_group" "app" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-app_tg"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  # default_action {
  #   type = "redirect"
  #   redirect {
  #     port        = "443"
  #     protocol    = "HTTPS"
  #     status_code = "HTTP_301"
  #   }
  # }
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-http_listener"
    }
  )
}

# resource "aws_lb_listener" "https_listener" {
#   load_balancer_arn = aws_lb.app_alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app_tg.arn
#   }

#   tags = merge(
#     var.tags,
#     {
#       "Name" = "${var.project_prefix}-https_listener"
#     }
#   )
# }

