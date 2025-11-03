output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}

output "nat_public_id" {
  description = "Public NAT Gateway ID (used by private subnets)"
  value       = aws_nat_gateway.nat_public.id
}

output "nat_private_id" {
  description = "Private NAT Gateway ID (used by non-routable subnets)"
  value       = aws_nat_gateway.nat_private.id
}

output "nat_public_eip" {
  description = "Elastic IP for public NAT Gateway"
  value       = aws_eip.nat_public.public_ip
}