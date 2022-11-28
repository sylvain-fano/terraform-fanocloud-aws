resource "aws_elasticache_subnet_group" "this" {
  name       = var.cluster_identifier
  subnet_ids = var.subnets_ids
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-elasticache_subnet_group"
    }
  )
}

resource "aws_elasticache_cluster" "this" {
  cluster_id         = var.cluster_identifier
  engine             = var.engine
  node_type          = var.node_type
  num_cache_nodes    = var.nodes_count
  az_mode            = var.az_mode
  port               = var.port
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = var.security_groups_ids
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-elasticache_cluster"
    }
  )
}
