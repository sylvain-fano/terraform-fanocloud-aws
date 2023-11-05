variable "region" {
  default     = "eu-west-3"
  description = "AWS region"
}

variable "keypair_path" {
  description = "Path to public key on your local machine"
}

variable "keypair_name" {
  description = "Name of your Keypair"
  default     = "terraform-kp"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}