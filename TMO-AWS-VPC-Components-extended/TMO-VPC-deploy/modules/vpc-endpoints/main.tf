# -------------------------
# Interface Endpoints for SSM
# -------------------------
resource "aws_vpc_endpoint" "ssm" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [var.security_group_id]
  private_dns_enabled = true

  tags = merge({ Name = "${var.name}-ssm-endpoint" }, var.tags)
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [var.security_group_id]
  private_dns_enabled = true

  tags = merge({ Name = "${var.name}-ec2messages-endpoint" }, var.tags)
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [var.security_group_id]
  private_dns_enabled = true

  tags = merge({ Name = "${var.name}-ssmmessages-endpoint" }, var.tags)
}

# -------------------------
# Gateway Endpoint for S3
# -------------------------
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids

  tags = merge({ Name = "${var.name}-s3-endpoint" }, var.tags)
}

# -------------------------
# Interface Endpoint for CloudWatch Logs
# -------------------------
resource "aws_vpc_endpoint" "logs" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.subnet_ids
  security_group_ids = [var.security_group_id]
  private_dns_enabled = true

  tags = merge({ Name = "${var.name}-logs-endpoint" }, var.tags)
}