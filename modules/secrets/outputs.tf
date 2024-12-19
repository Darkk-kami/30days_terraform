output "secret_id" {
  description = "The ID of the fetched secret from AWS Secrets Manager"
  value       = data.aws_secretsmanager_secret.secret.id
}

output "secret_data" {
  description = "The decoded secret data fetched from Secrets Manager"
  value       = local.secret_data
}

output "secret_version_id" {
  description = "The version ID of the fetched secret"
  value       = data.aws_secretsmanager_secret_version.secret_version.id
}
