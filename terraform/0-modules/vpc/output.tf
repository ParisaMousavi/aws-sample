output "vpc_id" {
  value = aws_vpc.this.id
}

output "default_route_table_id" {
  value = aws_vpc.this.main_route_table_id
}

output "private_subnets" {
  value =  [for k,v in aws_subnet.private : v.id]

}

output "public_subnets" {
  value =  [for k,v in aws_subnet.public : v.id]

}