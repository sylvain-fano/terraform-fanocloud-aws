resource "aws_security_group" "app" {
  name   = "${var.project_prefix}-app_sg"
  vpc_id = local.vpc.vpc_id
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = toset(local.vpc.bastion_security_group_ids)
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.tags,
    {
      "Name"        = "${var.project_prefix}-app_sg"
      "Description" = "Allow SSH from Bastions + HTTP from ALB"
    }
  )
}

resource "aws_security_group" "alb" {
  name   = "${var.project_prefix}-alb_sg"
  vpc_id = local.vpc.vpc_id
  dynamic "ingress" {
    for_each = toset([80, 443])
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.tags,
    {
      "Name"        = "${var.project_prefix}-alb_sg"
      "Description" = "Allow HTTP + HTTPS traffic to the ALB from the internet"
    }
  )
}
