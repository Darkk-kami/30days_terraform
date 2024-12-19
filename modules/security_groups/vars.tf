variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}

variable "tag" {
  description = "The tag prefix for naming resources"
  type        = string
  default     = "my-project"
}

variable "inbound_ports" {
  description = "A list of inbound ports to allow for the security group"
  type        = list(number)
  default     = [80]
}

variable "create_alb_ref_security_group" {
  description = "Whether to reference an ALB security group instead of CIDR blocks for ingress rules"
  type        = bool
  default     = false
}

variable "alb_sg" {
  description = "The ID of the ALB security group to reference, if enabled"
  type = object({
    id = string
  })
  default = {
    id = ""
  }
}
