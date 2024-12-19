output "key_pair_name" {
  description = "The name of the key pair created in AWS"
  value       = aws_key_pair.key_pair.key_name
}

output "private_key_path" {
  description = "The local file path where the private key is stored"
  value       = local_file.private_key.filename
}

output "public_key" {
  description = "The public key generated for the key pair"
  value       = tls_private_key.ssh_key.public_key_openssh
}
