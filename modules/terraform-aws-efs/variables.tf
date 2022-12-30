variable "region" {
  description = "AWS region"
  default     = "eu-west-3"
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

variable "vpc_context" {
  description = "VPC outputs"
  type        = map(any)
}

variable "db_context" {
  description = "DB outputs"
  type        = map(any)
}

variable "efs_context" {
  description = "EFS  outputs"
  type        = map(any)
}