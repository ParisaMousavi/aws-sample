resource "aws_default_route_table" "example" {
  default_route_table_id = var.default_route_table_id

  route = []

  tags = merge(
    var.tags,
    {
      created-by = "terraform"
      Name       = each.key
    },
  )
}
