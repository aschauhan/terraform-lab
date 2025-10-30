output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}

output "public_route_table_associations" {
  description = "Associations between public subnets and the public route table"
  value       = aws_route_table_association.public[*].id
}

output "private_route_table_associations" {
  description = "Associations between private subnets and the private route table"
  value       = aws_route_table_association.private[*].id
}

output "nonroutable_route_table_id" {
  value = aws_route_table.nonroutable.id
}