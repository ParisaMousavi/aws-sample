output "vpc_id" {
  value = aws_vpc.this.id
}

output "default_route_table_id" {
  value = aws_vpc.this.main_route_table_id
}