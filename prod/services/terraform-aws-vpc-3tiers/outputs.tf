output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets_ids" {
  value = aws_subnet.public.*.id
}

output "app_subnets_ids" {
  value = aws_subnet.app.*.id
}

output "db_subnets_ids" {
  value = aws_subnet.db.*.id
}

output "bastion_security_groups_ids" {
  description = "Security group for bastion ids"
  value       = aws_security_group.bastion.*.id
}
