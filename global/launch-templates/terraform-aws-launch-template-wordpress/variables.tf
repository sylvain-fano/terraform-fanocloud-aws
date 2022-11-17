variable "project_prefix" {
  description = "Project name to prefix created resources with"
  default     = "MyProject"
}

variable "env" {
  description = "Environment"
  default     = "prod"
}

variable "ec2_keypair_name" {
  description = "EC2 Keypair to use to connect to instances using SSH"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "app_title" {
  description = "App title"
  default     = "Application"
}

variable "app_url" {
  description = "App url"
}

variable "app_admin_username" {
  description = "App admin username"
  default     = "admin"
}

variable "app_admin_password" {
  description = "App admin password"
  default     = "password"
}

variable "app_admin_email" {
  description = "App admin email"
  default     = ""
}

variable "security_groups_ids" {
  description = "IDs of Securitygroups"
  type        = list(string)
  default     = []
}

variable "app_fs_id" {
  description = "ID of EFS shared filesystem"
  default     = ""
}

variable "db_host" {
  description = "Database host endpoint"
}

variable "db_name" {
  description = "Database name"
}

variable "tags" {
  default = {}
}
