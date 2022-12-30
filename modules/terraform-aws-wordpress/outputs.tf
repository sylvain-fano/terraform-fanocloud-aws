# output "alb_security_groups_ids" {
#   description = "Security group for APP ids"
#   value       = aws_security_group.alb.*.id
# }

# output "app_security_groups_ids" {
#   description = "Security group for APP ids"
#   value       = aws_security_group.app.*.id
# }

output "app_dns" {
  description = "DNS of application"
  value       = aws_lb.app.dns_name
}

output "app_url" {
  description = "URL of application"
  value       = "http://${aws_lb.app.dns_name}"
}
