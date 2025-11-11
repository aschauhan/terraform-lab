# -------------------------
# Public NACL
# -------------------------
resource "aws_network_acl" "public" {
  vpc_id = var.vpc_id
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-public-nacl-${var.region}"
    "Resource Type"       = "nacl"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_network_acl_rule" "public_inbound" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "public_outbound" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "public" {
  for_each       = var.public_subnet_map
  subnet_id      = each.value
  network_acl_id = aws_network_acl.public.id
}

# -------------------------
# Private NACL
# -------------------------
resource "aws_network_acl" "private" {
  vpc_id = var.vpc_id
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-private-nacl-${var.region}"
    "Resource Type"       = "nacl"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_network_acl_rule" "private_outbound_https" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "private_inbound_ephemeral" {
  network_acl_id = aws_network_acl.private.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_association" "private" {
  for_each       = var.private_subnet_map
  subnet_id      = each.value
  network_acl_id = aws_network_acl.private.id
}

# -------------------------
# Non-Routable NACL
# -------------------------
resource "aws_network_acl" "nonroutable" {
  vpc_id = var.vpc_id
  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-non-rt-nacl-${var.region}"
    "Resource Type"       = "nacl"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_network_acl_rule" "nonroutable_outbound_internal" {
  network_acl_id = aws_network_acl.nonroutable.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/8"
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_rule" "nonroutable_inbound_internal" {
  network_acl_id = aws_network_acl.nonroutable.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/8"
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_association" "nonroutable" {
  for_each       = var.nonroutable_subnet_map
  subnet_id      = each.value
  network_acl_id = aws_network_acl.nonroutable.id
}