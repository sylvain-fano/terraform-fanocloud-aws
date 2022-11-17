resource "aws_db_subnet_group" "this" {
  subnet_ids = var.subnets_ids
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-${var.cluster_identifier}-db_subnet_group"
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
  vpc_security_group_ids  = var.security_groups_ids
  master_username         = data.aws_ssm_parameter.db_username.value
  master_password         = data.aws_ssm_parameter.db_password.value
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
}