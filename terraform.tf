terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.80.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.6"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.2"
    }
  }

  # backend "s3" {
  #   bucket = "terraformstatebucketeks"
  #   key    = "terraform/30days"
  #   region = "us-east-1"
  # }
  # required_version = ">= 1.10.0"

  backend "remote" {
    organization = "Project-kami"

    workspaces {
      name = "kami-workspace"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # alias = "east"
}