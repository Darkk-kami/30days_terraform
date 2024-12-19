terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_secretsmanager_secret" "secret" {
  name = "mysecuresecret"
}

data "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = data.aws_secretsmanager_secret.secret.id
}

locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)
}