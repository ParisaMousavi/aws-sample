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

output "public_subnet_ids" {
  value =  {for k,v in aws_subnet.public : k => v.id}

}

output "internet_gateway_id" {
  value = var.with_internet_gateway == true ?  aws_internet_gateway.this[0].id : null
}