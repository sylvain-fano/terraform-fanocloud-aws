variable "project_prefix" {
  description = "Project name to prefix created resources with"
  default     = "MyProject"
}

variable "env" {
  description = "Environment"
  default     = "prod"
}

variable "tags" {
  default = {}
}

variable "subnets_ids" {
  description = "Subnets IDS to deploy elasticache cluster into"
  type        = list(string)
  default     = []
}

variable "security_groups_ids" {
  description = "Security groups IDS to give permissions to EC cluster"
  type        = list(string)
  default     = []
}

variable "cluster_identifier" {
  description = "Elasticache cluster identifier name"
  type        = string
  validation {
    condition     = can(regex("^[a-z]", var.cluster_identifier))
    error_message = "must begin with a lowercase letter"
  }
  validation {
    condition     = can(regex("[a-zA-Z0-9-]", var.cluster_identifier))
    error_message = "must contain only lowercase alphanumeric characters and hyphens"
  }
}

variable "node_type" {
  default = "cache.t4g.micro"
}

variable "nodes_count" {
  description = "Nodes count (must be > 2 if cross-az and 1 if single-az)"
  default     = 2
}

variable "az_mode" {
  description = "AZ mode (single-az or cross-az)"
  default     = "cross-az"
}

variable "port" {
  description = "Memcached port"
  default     = 11211
}

variable "engine" {
  description = "Engine mode (memcached , redis)"
  default     = "memcached"
}
