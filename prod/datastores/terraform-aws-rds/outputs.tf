output "db_host" {
  description = "DB Host endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "db_name" {
  description = "DB Name"
  value       = aws_rds_cluster.this.database_name
}

output "db_master_username" {
  description = "DB master Username"
  value       = aws_rds_cluster.this.master_username
  sensitive   = true
}

output "db_master_password" {
  description = "DB master Password"
  value       = aws_rds_cluster.this.master_password
  sensitive   = true
}
