output "public_subnets" {
  value = aws_subnet.public[*].id
}
output "private_subnets" {
  value = aws_subnet.private[*].id
}
output "nonroutable_subnets" {
  value = aws_subnet.nonroutable[*].id
}
output "additional_subnets" {
  description = "IDs of subnets created from additional CIDRs"
  value       = aws_subnet.additional[*].id
}