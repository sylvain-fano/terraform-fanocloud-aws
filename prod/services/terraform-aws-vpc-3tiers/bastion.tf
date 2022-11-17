resource "aws_security_group" "bastion" {
  name   = "${var.project_prefix}-bastion_sg"
  vpc_id = aws_vpc.this.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.mgmt_networks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.tags,
    {
      "Name"        = "${var.project_prefix}-bastion_sg"
      "Description" = "Allow SSH to Bastions from private management network"
    }
  )
}

resource "aws_autoscaling_group" "bastion" {
  name                = "${var.project_prefix}-bastion_asg"
  desired_capacity    = var.bastion_asg_desired_capacity
  min_size            = var.bastion_asg_min_size
  max_size            = var.bastion_asg_max_size
  vpc_zone_identifier = aws_subnet.public[*].id

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}

data "aws_ami" "amz_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_launch_template" "this" {
  name          = "${var.project_prefix}-bastion_lt"
  description   = "Launch Template for the Bastion instance"
  image_id      = data.aws_ami.amz_linux_2.id
  instance_type = var.bastion_instance_type
  key_name      = var.ec2_keypair_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.bastion.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        "Name" = "${var.project_prefix}-bastion_lt"
      }
    )
  }
}





