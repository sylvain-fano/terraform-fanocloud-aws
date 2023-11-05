variable "region" {
  default     = "eu-west-3"
  description = "AWS region"
}

variable "azs" {
  description = "AWS Availability zones"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"]
}

variable "cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  # default     = "10.16.0.0/16"
}

variable "public_subnets_cidr" {
  description = "Public subnet cidr Block"
  type        = list(string)
  # default     = ["10.16.0.0/24", "10.16.1.0/24"]
}

variable "private_subnets_cidr" {
  description = "Private subnet cidr Block"
  type        = list(string)
  # default     = ["10.16.10.0/24", "10.16.11.0/24"]
}

variable "database_subnets_cidr" {
  description = "Database subnet cidr Block"
  type        = list(string)
  # default     = ["10.16.20.0/24", "10.16.21.0/24"]
}

variable "project_prefix" {
  description = "Project name to prefix created resources with"
  default     = "MyProject"
}

variable "env" {
  description = "Environment"
  default     = "prod"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "mgmt_networks" {
  description = "CIDR list of allowed managements networks to operate cluster"
  type        = list(string)
  sensitive   = true
  default     = []
}

variable "ec2_keypair_name" {
  description = "EC2 Keypair to use to connect to instances using SSH"
  sensitive   = true
  default     = "terraform-kp"
}

variable "bastion_asg_desired_capacity" {
  default = 1
}

variable "bastion_asg_min_size" {
  default = 1
}

variable "bastion_asg_max_size" {
  default = 1
}

variable "bastion_instance_type" {
  description = "Bastion EC2 instance type"
  default     = "t3.micro"
}