# -------------------------
# Environment Metadata
# -------------------------
name     = "dev-us-east-1"
application_ou_name = "ntw"
environment = "dev"
region   = "us-east-1"
azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]

# -------------------------
# VPC CIDRs
# -------------------------
# vpc_cidr = "10.0.0.0/16"
 vpc_cidr = "10.65.0.0/24"

additional_cidrs = [
  "100.65.0.0/20",
  "100.64.0.0/24"
]

# -------------------------
# Subnet CIDRs
# -------------------------
public_subnet_cidrs = [
  "100.65.0.0/26",
  "100.65.0.64/26",
  "100.65.0.128/26"
]

private_subnet_cidrs = [
  "10.65.0.0/28",
  "10.65.0.16/28",
  "10.65.0.32/28"
]

nonroutable_subnet_cidrs = [
  "100.64.0.0/28",
  "100.64.0.16/28",
  "100.64.0.32/28"
]

# -------------------------
# DHCP Options
# -------------------------
domain_name          = "dev.internal"
domain_name_servers  = ["AmazonProvidedDNS"]
ntp_servers          = ["169.254.169.123"]
netbios_name_servers = ["10.0.101.10"]
netbios_node_type    = 2

