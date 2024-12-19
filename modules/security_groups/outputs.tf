output "web_security_group" {
  description = "The ID of the created web security group"
  value       = aws_security_group.web_sg
}

output "web_ingress_rule_ids" {
  description = "The IDs of the created ingress rules"
  value       = [for rule in aws_vpc_security_group_ingress_rule.allow_http : rule.id]
}

output "web_egress_rule_id" {
  description = "The ID of the created egress rule"
  value       = aws_vpc_security_group_egress_rule.app_allow_all_outbound.id
}
