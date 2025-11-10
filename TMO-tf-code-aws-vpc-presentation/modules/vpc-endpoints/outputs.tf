output "ssm_endpoint_id" {
  description = "Interface endpoint ID for AWS Systems Manager (SSM)"
  value       = aws_vpc_endpoint.ssm.id
}

output "ec2messages_endpoint_id" {
  description = "Interface endpoint ID for EC2 Messages service"
  value       = aws_vpc_endpoint.ec2messages.id
}

output "ssmmessages_endpoint_id" {
  description = "Interface endpoint ID for Session Manager messages"
  value       = aws_vpc_endpoint.ssmmessages.id
}

output "logs_endpoint_id" {
  description = "Interface endpoint ID for CloudWatch Logs"
  value       = aws_vpc_endpoint.logs.id
}

output "s3_endpoint_id" {
  description = "Gateway endpoint ID for Amazon S3"
  value       = aws_vpc_endpoint.s3.id
}