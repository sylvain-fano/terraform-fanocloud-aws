resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-public_route_table"
    }
  )
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.this.id
  count  = length(var.azs)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngws[count.index].id
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-app_route_table-${var.azs[count.index]}"
    }
  )
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.this.id
  count  = length(var.azs)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngws[count.index].id
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${var.project_prefix}-db_route_table-${var.azs[count.index]}"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "app" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app[count.index].id
}

resource "aws_route_table_association" "db" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db[count.index].id
}