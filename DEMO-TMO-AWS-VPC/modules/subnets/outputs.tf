output "public_subnet_ids" { value = aws_subnet.public[*].id }
output "private_subnet_ids" { value = aws_subnet.private[*].id }
output "non_routable_subnet_ids" { value = aws_subnet.non_routable[*].id }