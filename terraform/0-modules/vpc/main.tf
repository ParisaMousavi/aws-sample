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
    },
  )
}

resource "aws_internet_gateway" "this" {
  count = var.with_internet_gateway == true ? 1 : 0
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
      aws_internet_gateway.this
  ]
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
