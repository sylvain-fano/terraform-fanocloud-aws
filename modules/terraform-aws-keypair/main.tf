resource "aws_key_pair" "ec2_keypair" {
  key_name   = var.keypair_name
  public_key = file(var.keypair_path)

  tags = var.tags
}
