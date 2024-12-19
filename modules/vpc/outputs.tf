output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = [for subnet in aws_subnet.public_subnets : subnet]
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = [for subnet in aws_subnet.private_subnets : subnet]
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.internet_gateway.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_route_table.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_route_table.id
}
