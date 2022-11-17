variable "region" {
  default     = "eu-west-3"
  description = "AWS region"
}

variable "azs" {
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]
  description = "AWS Availability zones"
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

variable "app_asg_desired_capacity" {
  default = 2
}

variable "app_asg_min_size" {
  default = 2
}

variable "app_asg_max_size" {
  default = 4
}

variable "app_fs_id" {
  description = "EFS filesystem ID used to create VPC AZ mount points"
  default     = ""
}

variable "app_launch_template_id" {
  description = "App launch template ID"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "bastion_security_group_id" {
  description = "Bastion Security Group ID to allow communication from"
}
