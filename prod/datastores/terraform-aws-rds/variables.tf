variable "region" {
  default     = "eu-west-3"
  description = "AWS region"
}

variable "project_prefix" {
  description = "Project name to prefix created resources with"
}

variable "env" {
  description = "Environment"
  default     = "prod"
}

variable "tags" {
  default = {}
}

variable "cluster_identifier" {
  type = string
  validation {
    condition     = can(regex("^[a-z]", var.cluster_identifier))
    error_message = "first char must be a lower case letter"
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]*$", var.cluster_identifier))
    error_message = "only alphanumerical and hyphens allowed"
  }
}

variable "engine" {
  default = "aurora-mysql"
}

variable "engine_mode" {
  default = "serverless"
}

variable "database_name" {
  type = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9]*$", var.database_name))
    error_message = "only alphanumerical allowed"
  }
}

variable "backup_retention_period" {
  default = 7
}

variable "min_capacity" {
  default = 1
}

variable "max_capacity" {
  default = 2
}

variable "security_groups_ids" {
  description = "IDs of Securitygroups"
  type        = list(string)
  default     = []
}

variable "subnets_ids" {
  description = "IDs of Subnets"
  type        = list(string)
  default     = []
}
