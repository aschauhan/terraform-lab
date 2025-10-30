########################################
# Provider & Variables
########################################
provider "aws" {
  region = "us-east-1"
}
 
variable "app_ports" {
  type    = list(number)
  default = [8080, 9090, 7070]
}
 
########################################
# VPC & Networking
########################################
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "demo-vpc" }
}
 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "demo-igw" }
}
 
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet" }
}
 
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "private-subnet" }
}
 
########################################
# Route Tables
########################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
 
  tags = { Name = "public-rt" }
}
 
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
 
########################################
# Network Firewall
########################################
resource "aws_networkfirewall_rule_group" "allow_web" {
  name     = "allow-web-rules"
  capacity = 100
  type     = "STATEFUL"
 
  rule_group {
    rules_source {
      rules_string = <<-EOT
        pass tcp any any -> any 8080 (sid:1;)
        pass tcp any any -> any 9090 (sid:2;)
        pass tcp any any -> any 7070 (sid:3;)
      EOT
    }
  }
 
  tags = {
    Name = "allow-web-rules"
  }
}
 
resource "aws_networkfirewall_firewall_policy" "policy" {
  name = "demo-firewall-policy"
 
  firewall_policy {
    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.allow_web.arn
    }
 
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]
  }
 
  tags = {
    Name = "demo-firewall-policy"
  }
}
 
resource "aws_networkfirewall_firewall" "firewall" {
  name                = "demo-firewall"
  vpc_id              = aws_vpc.main.id
  firewall_policy_arn = aws_networkfirewall_firewall_policy.policy.arn
 
  subnet_mapping {
    subnet_id = aws_subnet.public.id
  }
 
  tags = {
    Name = "demo-firewall"
  }
}
 
# Query firewall endpoint info
data "aws_networkfirewall_firewall" "firewall_data" {
  name = aws_networkfirewall_firewall.firewall.name
}
 
########################################
# Private Route Table (Firewall Endpoint)
########################################
locals {
  firewall_status = tolist(data.aws_networkfirewall_firewall.firewall_data.firewall_status)
  # Extract the only sync_state object
  sync_state      = one(local.firewall_status[0].sync_states)
  # Extract the first (only) attachment object
  attachment_obj  = local.sync_state.attachment[0]
}
 
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
 
  route {
    cidr_block      = "0.0.0.0/0"
    vpc_endpoint_id = local.attachment_obj.endpoint_id
  }
 
  tags = { Name = "private-rt" }
}
 
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}
 
########################################
# Security Groups
########################################
# Backend SG (for app ports)
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow app ports"
  vpc_id      = aws_vpc.main.id
 
  dynamic "ingress" {
    for_each = var.app_ports
    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = { Name = "backend-sg" }
}
 
# ALB SG (HTTP)
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.main.id
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = { Name = "alb-sg" }
}
 
########################################
# Backend EC2 Instances (3 Apps)
########################################
resource "aws_instance" "backend_apps" {
  count         = length(var.app_ports)
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  associate_public_ip_address = false
 
  user_data = <<-EOF
    #!/bin/bash
    yum install -y httpd
    echo "App running on port ${var.app_ports[count.index]}" > /var/www/html/index.html
    sed -i "s/Listen 80/Listen ${var.app_ports[count.index]}/" /etc/httpd/conf/httpd.conf
    systemctl enable httpd
    systemctl start httpd
  EOF
 
  tags = { Name = "backend-app-${var.app_ports[count.index]}" }
}

# Add a second public subnet in another AZ
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-b" }
}
 
# Associate the new subnet with the public route table
resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

########################################
# Application Load Balancer
########################################
resource "aws_lb" "app_lb" {
  name               = "demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public_b.id]
  tags = { Name = "demo-alb" }
}
 
# Target groups for each backend app
resource "aws_lb_target_group" "tg" {
  count       = length(var.app_ports)
  name        = "app-tg-${var.app_ports[count.index]}"
  port        = var.app_ports[count.index]
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"
 
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
 
# Attach instances to TGs
resource "aws_lb_target_group_attachment" "tg_attach" {
  count            = length(var.app_ports)
  target_group_arn = aws_lb_target_group.tg[count.index].arn
  target_id        = aws_instance.backend_apps[count.index].id
  port             = var.app_ports[count.index]
}
 
# ALB Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"
 
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Invalid path. Try /app1, /app2, or /app3"
      status_code  = "404"
    }
  }
}
 
# Path-based rules
resource "aws_lb_listener_rule" "app_rules" {
  count             = length(var.app_ports)
  listener_arn      = aws_lb_listener.http_listener.arn
  priority          = count.index + 1
 
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[count.index].arn
  }
 
  condition {
    path_pattern {
      values = ["/app${count.index + 1}/*"]
    }
  }
}
 
########################################
# Outputs
########################################
output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}
 
output "backend_instance_private_ips" {
  value = [for i in aws_instance.backend_apps : i.private_ip]
}
 
output "firewall_endpoint_status" {
  value = data.aws_networkfirewall_firewall.firewall_data.firewall_status
}