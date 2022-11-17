output "cluster_id" {
  value       = aws_elasticache_cluster.this.cluster_id
  description = "Cluster ID"
}

output "cluster_address" {
  value       = aws_elasticache_cluster.this.cluster_address
  description = "Cluster address"
}

output "cluster_configuration_endpoint" {
  value       = aws_elasticache_cluster.this.configuration_endpoint
  description = "Cluster configuration endpoint"
}
