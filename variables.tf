variable "mgmt_networks" {
  type        = list(string)
  default     = []
  description = "CIDR list of allowed managements networks to operate cluster"
  sensitive   = true

}

variable "ec2_keypair_name" {
  description = "EC2 Keypair to use to connect to instances using SSH"
  sensitive   = true
}

variable "app_password" {
  sensitive = true
}
