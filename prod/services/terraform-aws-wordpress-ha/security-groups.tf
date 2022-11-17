resource "aws_security_group" "app" {
  name   = "${var.project_prefix}-app_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id]
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

resource "aws_security_group" "db" {
  name   = "${var.project_prefix}-db_sg"
  vpc_id = var.vpc_id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id, aws_security_group.app.id]
  }
  ingress {
    from_port       = 11211
    to_port         = 11211
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id, aws_security_group.app.id]
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
      "Name"        = "${var.project_prefix}-db_sg"
      "Description" = "Allow SQL + Memcached from Bastions + Apps"
    }
  )
}

resource "aws_security_group" "alb" {
  name   = "${var.project_prefix}-alb_sg"
  vpc_id = var.vpc_id
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

resource "aws_security_group" "efs" {
  name   = "${var.project_prefix}-efs_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
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
      "Name"        = "${var.project_prefix}-efs_sg"
      "Description" = "Opening EFS mount target port"
    }
  )
}
