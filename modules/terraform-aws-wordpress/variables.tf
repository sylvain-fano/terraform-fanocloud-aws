variable "region" {
  default     = "eu-west-3"
  description = "AWS region"
}

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

variable "ec2_keypair_name" {
  description = "EC2 Keypair to use to connect to instances using SSH"
  sensitive   = true
}

variable "asg_desired_capacity" {
  description = "Auto Scaling group desired capacity for Apps instances"
  default     = 2
}

variable "asg_min_size" {
  description = "Auto Scaling group minimum capacity for Apps instances"
  default     = 2
}

variable "asg_max_size" {
  description = "Auto Scaling group maximum capacity for Apps instances"
  default     = 4
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "app_title" {
  description = "App title"
  default     = "Application"
}

variable "admin_username" {
  description = "App admin username"
  default     = "admin"
}

variable "admin_password" {
  description = "App admin password"
  default     = "password"
}

variable "admin_email" {
  description = "App admin email"
  default     = ""
}