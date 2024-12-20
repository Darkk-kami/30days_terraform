variable "distro_version" {
  description = "The Ubuntu distribution version (e.g., '22.04' or '20.04')"
  type        = string
  default     = "22.04"
}

variable "instance_type" {
  description = "The EC2 instance type (e.g., 't2.micro', 't2.small')"
  type        = string
  default     = "t2.micro"
}

variable "public_subnets" {
  description = "A list of public subnets where instances can be launched"
}

variable "web_sg" {
  description = "The security group for the web server"
  type = object({
    id = string
  })
}

variable "ssh_key" {
  description = "The key pair object used for instance SSH access (optional)"
  type = object({
    key_name = string
  })
  default = null
}

variable "secret_data" {
  description = "An object containing sensitive or dynamic data for the instance"
  type = object({
    hello_text = string
  })
  default = {
    hello_text = "Terraform!"
  }
}

variable "instance_count" {
  default = 1
}

variable "tags" {
}