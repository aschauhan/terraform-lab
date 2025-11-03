vpc_cidr = "10.1.0.0/16"
name     = "prod-us-east-1"
azs      = ["us-east-1a","us-east-1b","us-east-1c"]

public_subnet_cidrs      = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
private_subnet_cidrs     = ["10.1.101.0/24","10.1.102.0/24","10.1.103.0/24"]
nonroutable_subnet_cidrs = ["10.1.201.0/24","10.1.202.0/24","10.1.203.0/24"]

domain_name          = "prod.internal"
domain_name_servers  = ["AmazonProvidedDNS"]
ntp_servers          = ["169.254.169.123"]
netbios_name_servers = ["10.1.101.10"]
netbios_node_type    = 2