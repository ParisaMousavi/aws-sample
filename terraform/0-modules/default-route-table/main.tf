data "aws_vpc" "this" {
  id = var.vpc_id
}

// I wanted to pass the default_route_table_id attribute as variable to this module
// but terraform didn't allow and forced me to use -target in apply.
// Therefore added the aws_vpc data block
resource "aws_default_route_table" "this" {
  default_route_table_id = data.aws_vpc.this.main_route_table_id
  route                  = []
  tags = merge(
    var.tags,
    {
      created-by = "terraform"
    },
  )
}

resource "aws_route" "this" {
  depends_on = [
    aws_default_route_table.this
  ]
  for_each = var.routes
  route_table_id         = data.aws_vpc.this.main_route_table_id
  destination_cidr_block = each.value.cidr_block
  gateway_id             = each.value.gateway_id
}

resource "aws_route_table_association" "public" {
  for_each       = toset(var.subnet_ids)
  subnet_id      = each.value
  route_table_id = data.aws_vpc.this.main_route_table_id
}
