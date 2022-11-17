output "db_host" {
  description = "DB Host endpoint"
  value       = aws_rds_cluster.this.endpoint
}

output "db_name" {
  description = "DB Name"
  value       = aws_rds_cluster.this.database_name
}