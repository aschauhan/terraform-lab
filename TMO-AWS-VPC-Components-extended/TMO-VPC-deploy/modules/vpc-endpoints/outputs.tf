output "ssm_endpoint_id" {
  value = aws_vpc_endpoint.ssm.id
}
output "ec2messages_endpoint_id" {
  value = aws_vpc_endpoint.ec2messages.id
}
output "ssmmessages_endpoint_id" {
  value = aws_vpc_endpoint.ssmmessages.id
}
output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}
output "logs_endpoint_id" {
  value = aws_vpc_endpoint.logs.id
}