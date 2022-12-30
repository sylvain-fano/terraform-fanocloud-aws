output "efs_id" {
  description = "EFS filesystem ID"
  value       = aws_efs_file_system.this.id
}