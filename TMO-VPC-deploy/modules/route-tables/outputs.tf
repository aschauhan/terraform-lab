# Public route table (shared)
output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "public_route_table_associations" {
  description = "Associations between public subnets and the public route table"
  value       = aws_route_table_association.public[*].id
}

# Private route tables (one per subnet)
output "private_route_table_ids" {
  description = "List of private route table IDs (one per private subnet)"
  value       = aws_route_table.private[*].id
}

output "private_route_table_associations" {
  description = "Associations between private subnets and their respective route tables"
  value       = aws_route_table_association.private[*].id
}

# Non-routable route tables (one per subnet)
output "nonroutable_route_table_ids" {
  description = "List of non-routable route table IDs (one per non-routable subnet)"
  value       = aws_route_table.nonroutable[*].id
}

output "nonroutable_route_table_associations" {
  description = "Associations between non-routable subnets and their respective route tables"
  value       = aws_route_table_association.nonroutable[*].id
}