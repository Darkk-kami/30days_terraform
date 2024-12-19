output "web_server_id" {
  description = "The ID of the created web server instance"
  value       = aws_instance.web_server.id
}

output "web_server_public_ip" {
  description = "The public IP address of the web server instance"
  value       = aws_instance.web_server.public_ip
}

output "web_server_ami" {
  description = "The AMI ID used for the web server instance"
  value       = aws_instance.web_server.ami
}

output "web_server_instance_type" {
  description = "The instance type of the web server"
  value       = aws_instance.web_server.instance_type
}
