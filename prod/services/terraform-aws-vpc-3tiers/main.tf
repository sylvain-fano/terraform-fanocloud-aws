resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-vpc"
    }
  )
}

resource "aws_subnet" "public" {
  count = length(var.azs)

  vpc_id            = aws_vpc.this.id
  availability_zone = var.azs[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index)
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-public_subnet-${var.azs[count.index]}"
    }
  )
}

resource "aws_subnet" "app" {
  count = length(var.azs)

  vpc_id            = aws_vpc.this.id
  availability_zone = var.azs[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, 8, 10 + count.index)
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-app_subnet-${var.azs[count.index]}"
    }
  )
}

resource "aws_subnet" "db" {
  count = length(var.azs)

  vpc_id            = aws_vpc.this.id
  availability_zone = var.azs[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, 8, 20 + count.index)
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-db_subnet-${var.azs[count.index]}"
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-igw"
    }
  )
}

resource "aws_eip" "eips" {
  count = length(var.azs)

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-eip-${var.azs[count.index]}"
    }
  )

  depends_on = [
    aws_internet_gateway.this # IGW must be created before EIPs
  ]
}

resource "aws_nat_gateway" "ngws" {
  count = length(var.azs)

  allocation_id = aws_eip.eips[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-ngw-${var.azs[count.index]}"
    }
  )
}

# resource "aws_efs_mount_target" "app_fs" {
#   count = length(aws_subnet.app)

#   file_system_id  = var.app_fs_id
#   subnet_id       = aws_subnet.app[count.index].id
#   security_groups = [aws_security_group.efs.id]
# }