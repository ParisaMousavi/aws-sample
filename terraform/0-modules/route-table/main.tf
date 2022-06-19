data "aws_vpc" "default" {
  id = var.vpc_id
}

// I wanted to pass the default_route_table_id attribute as variable to this module
// but terraform didn't allow and forced me to use -target in apply.
// Therefore added the aws_vpc data block
resource "aws_default_route_table" "this" {
  default_route_table_id = data.aws_vpc.default.main_route_table_id
  route                  = []
  tags = merge(
    var.tags,
    {
      created-by = "terraform"
    },
  )
}

resource "aws_route_table" "this" {
  count  = var.routes == null ? 0 : 1
  vpc_id = var.vpc_id
  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block     = route.value.cidr_block
      nat_gateway_id = route.value.nat_gateway_id
    }
  }
  tags = merge(
    var.tags,
    {
      created-by = "terraform"
    },
  )
}

resource "aws_route_table_association" "private" {
  for_each       = toset(var.subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.this[0].id
}
