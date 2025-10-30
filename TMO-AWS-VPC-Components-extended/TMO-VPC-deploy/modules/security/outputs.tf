output "default_sg_id" {
  value = aws_security_group.default.id
}

output "endpoints_sg_id" {
  value = aws_security_group.endpoints.id
}