output "url" {
  description = "DNS endpoint of web application"
  value       = "http://${module.wordpress_cluster_ha.alb_dns}"
}

output "username" {
  description = "username of web application"
  value       = random_string.app_username.result
}

output "password" {
  description = "password of web application"
  value       = random_password.app_password.result
  sensitive   = true
}

# output "bastion_ssh" {
#   description = "SSH access for bastion"
#   value = module.bastion-lt.
# }
