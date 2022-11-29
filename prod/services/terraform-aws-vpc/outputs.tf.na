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

output "public_cidr_blocks" {
  description = "Public CIDR blocks"
  value       = aws_subnet.public.*.cidr_block
}

output "app_cidr_blocks" {
  description = "App CIDR blocks"
  value       = aws_subnet.app.*.cidr_block
}

output "db_cidr_blocks" {
  description = "DB CIDR blocks"
  value       = aws_subnet.db.*.cidr_block
}

output "bastion_security_group_ids" {
  description = "Bastion Security Groups IDs"
  value       = aws_security_group.bastion.*.id
}

