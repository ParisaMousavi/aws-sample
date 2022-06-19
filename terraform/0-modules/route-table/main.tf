resource "aws_route_table" "this" {
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

data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.subnet_tag_name
  }
}

resource "aws_route_table_association" "private" {
  for_each       = toset(data.aws_subnet_ids.private.ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.this.id
}
