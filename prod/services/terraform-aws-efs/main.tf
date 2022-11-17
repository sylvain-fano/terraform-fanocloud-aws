resource "aws_efs_file_system" "app_fs" {
  creation_token   = var.project_prefix
  performance_mode = "generalPurpose"

  lifecycle_policy {
    transition_to_ia = "AFTER_60_DAYS"
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-app_fs"
    }
  )
}
