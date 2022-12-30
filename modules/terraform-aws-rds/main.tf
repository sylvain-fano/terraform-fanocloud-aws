locals {
  vpc = var.vpc_context
}

resource "random_string" "db_username" {
  length  = 12
  special = false
  upper   = false
  numeric = false
}

resource "random_password" "db_password" {
  length           = 24
  special          = true
  override_special = "!#$%^*()-=+_?{}|"
}

resource "aws_db_subnet_group" "this" {
  # subnet_ids = local.vpc.db_subnets_ids
  subnet_ids = local.vpc.database_subnets
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-${var.cluster_identifier}-db_subnet_group"
    }
  )
}

resource "aws_security_group" "this" {
  name   = "${var.project_prefix}-db_sg"
  vpc_id = local.vpc.vpc_id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    # cidr_blocks = concat(local.vpc.app_cidr_blocks, local.vpc.public_cidr_blocks)
    cidr_blocks = local.vpc.private_subnets_cidr_blocks
    # security_groups = [local.vpc.aws_security_group.bastion.id, local.vpc.app_security_group_id]
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

resource "aws_rds_cluster" "this" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_mode             = var.engine_mode
  database_name           = var.database_name
  enable_http_endpoint    = true
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.this.id]
  master_username         = random_string.db_username.result
  master_password         = random_password.db_password.result
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-${var.cluster_identifier}"
    }
  )

  scaling_configuration {
    min_capacity             = var.min_capacity
    max_capacity             = var.max_capacity
    auto_pause               = true
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

resource "aws_ssm_parameter" "db_host" {
  name        = format("/%s/db/host", var.project_prefix)
  description = "Database host for app"
  type        = "String"
  value       = aws_rds_cluster.this.endpoint
  overwrite   = true
}

resource "aws_ssm_parameter" "db_name" {
  name        = format("/%s/db/name", var.project_prefix)
  description = "Database name for app"
  type        = "String"
  value       = aws_rds_cluster.this.database_name
  overwrite   = true
}

resource "aws_ssm_parameter" "db_username" {
  name        = format("/%s/db/master_username", var.project_prefix)
  description = "Database username for app"
  type        = "String"
  value       = aws_rds_cluster.this.master_username
  overwrite   = true
}

resource "aws_ssm_parameter" "db_password" {
  name        = format("/%s/db/master_password", var.project_prefix)
  description = "Database password for app"
  type        = "String"
  value       = aws_rds_cluster.this.master_password
  overwrite   = true
}
