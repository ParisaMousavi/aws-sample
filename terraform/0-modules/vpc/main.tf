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

#-----------------------------------------------
#               internet gateway 
#               if internet gateway is needed
#-----------------------------------------------
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

#-----------------------------------------------
#               add internet gateway to the default route table
#               if internet gateway is needed
#-----------------------------------------------
resource "aws_route" "this" {
  count = var.with_internet_gateway == true ? 1 : 0
  depends_on = [
    aws_internet_gateway.this[0]
  ]
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}


#-----------------------------------------------
#               update default route table tags
#-----------------------------------------------
resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.main_route_table_id
  tags = merge(
    var.tags,
    {
      created-by = "terraform"
      Name = var.default_route_table_name
    },
  )
}


#-----------------------------------------------
#               private subnet
#-----------------------------------------------
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

#-----------------------------------------------
#               subnet subnet
#-----------------------------------------------
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

#-----------------------------------------------
#               associate public subnet with
#               the deafult route table
#-----------------------------------------------
resource "aws_route_table_association" "this" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_vpc.this.main_route_table_id
}