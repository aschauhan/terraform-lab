resource "aws_vpc_dhcp_options" "this" {
  domain_name          = var.domain_name
  domain_name_servers  = var.domain_name_servers
  ntp_servers          = var.ntp_servers
  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type

  tags = merge(
  {
    Name                  = "${var.application_ou_name}-${var.environment}-dhcp-options-${var.region}"
    "Resource Type"       = "dhcp-option"
    "Creation Date"       = timestamp()
    "Environment"         = var.environment
    "Application ou name" = var.application_ou_name
    "Created by"          = "Cloud Network Team"
    "Region"              = var.region
  },var.base_tags
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  vpc_id          = var.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.this.id
}