output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "nat_public_id" {
  value = aws_nat_gateway.nat_public.id
}

output "nat_private_id" {
  value = aws_nat_gateway.nat_private.id
}