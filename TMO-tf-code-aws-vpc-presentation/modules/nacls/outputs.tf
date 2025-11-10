output "public_nacl_id" {
  value = aws_network_acl.public.id
}

output "private_nacl_id" {
  value = aws_network_acl.private.id
}

output "nonroutable_nacl_id" {
  value = aws_network_acl.nonroutable.id
}