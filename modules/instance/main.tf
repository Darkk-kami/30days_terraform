terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-*-${var.distro_version}-amd64-server-*"]
  }
  owners = ["099720109477"]
}

data "aws_ec2_instance_type" "instance" {
  instance_type = var.instance_type
}

resource "aws_instance" "web_server" {
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = var.public_subnets[0].id
  vpc_security_group_ids = [var.web_sg.id]
  key_name               = var.ssh_key != null ? var.ssh_key.key_name : null

  user_data              = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "<h1>Hello from ${var.secret_data.hello_text}</h1>" | sudo tee /var/www/html/index.html
  EOT

  lifecycle {
    precondition {
      condition = (
        data.aws_ec2_instance_type.instance.free_tier_eligible || 
        var.instance_type == "t2.small" 
      ) && (
        contains(["unsupported"], data.aws_ec2_instance_type.instance.ebs_optimized_support)
        )

      error_message = "Instance must be part of Free tier, or 't2.small', and must not be EBS optimized."
    }
  }
}
