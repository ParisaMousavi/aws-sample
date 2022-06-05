#-----------------------------------------------
#               VPC
#-----------------------------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      created-by = "terraform"
      Name       = var.name
    },
  )
}

resource "aws_internet_gateway" "this" {
  count  = var.with_internet_gateway == true ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      created-by = "terraform"
    },
  )
}

resource "aws_route" "this" {
  count = var.with_internet_gateway == true ? 1 : 0
  depends_on = [
    aws_internet_gateway.this[0]
  ]
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  vpc_id            = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      created-by = "terraform"
      Name       = each.key
    },
  )
}

resource "aws_subnet" "public" {
  for_each          = var.public_subnets
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  vpc_id            = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      created-by = "terraform"
      Name       = each.key
    },
  )
}

// this is only for oublic subnets
resource "aws_route_table_association" "this" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_vpc.this.main_route_table_id
}