output "kp_name" {
  description = "Keypair name"
  value       = aws_key_pair.ec2_keypair.key_name
}