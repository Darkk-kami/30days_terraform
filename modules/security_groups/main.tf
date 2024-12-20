terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # configuration_aliases = [ aws.east ]
    }
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow TLS traffic inbound and all outbound"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.tag}-sg"
  }
}
# Conditional creation of ingress rule
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  for_each          = { for idx, port in var.inbound_ports : idx => port }
  security_group_id = aws_security_group.web_sg.id
  from_port         = each.value
  to_port           = each.value
  ip_protocol       = "tcp"

  # Conditionally set referenced_security_group_id
  referenced_security_group_id = var.create_alb_ref_security_group ? var.alb_sg.id : null


  # Conditionally set cidr_blocks
  cidr_ipv4 = var.create_alb_ref_security_group ? null : "0.0.0.0/0"
}
# Conditional creation of egress rule
resource "aws_vpc_security_group_egress_rule" "app_allow_all_outbound" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}