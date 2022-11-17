output "alb_security_groups_ids" {
  description = "Security group for APP ids"
  value       = aws_security_group.alb.*.id
}

output "app_security_groups_ids" {
  description = "Security group for APP ids"
  value       = aws_security_group.app.*.id
}

output "db_security_groups_ids" {
  description = "Security group for DB ids"
  value       = aws_security_group.db.*.id
}

output "alb_dns" {
  description = "DNS endpoint of application"
  value       = aws_lb.app.dns_name
}
