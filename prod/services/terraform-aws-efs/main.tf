locals {
  vpc = data.terraform_remote_state.vpc.outputs
}

resource "aws_efs_file_system" "this" {
  creation_token   = var.project_prefix
  performance_mode = "generalPurpose"
  throughput_mode = "bursting" 
  encrypted = true

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
    # transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-app_fs"
    }
  )
}

resource "aws_efs_mount_target" "this" {
  count = length(local.vpc.app_subnets_ids)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = local.vpc.app_subnets_ids[count.index]
  security_groups = [aws_security_group.this.id]
}

resource "aws_security_group" "this" {
  name   = "${var.project_prefix}-efs_sg"
  vpc_id = local.vpc.vpc_id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    # security_groups = local.vpc.app_security_group_ids
    cidr_blocks = local.vpc.app_cidr_blocks
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