variable "project_prefix" {
  default     = "MyProject"
  description = "Project name to prefix created resources with"
}

variable "env" {
  description = "Environment"
  default     = "prod"
}

variable "tags" {
  default = {}
}
