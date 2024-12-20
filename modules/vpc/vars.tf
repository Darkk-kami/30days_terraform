variable "tag" {
  description = "The tag prefix for naming resources"
  default     = "my-project"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_no" {
  description = "The number of public subnets to create"
  type        = number
  default     = 2
}

variable "private_subnets_no" {
  description = "The number of private subnets to create"
  type        = number
  default     = 2
}

