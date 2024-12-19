variable "tag" {
  type    = string
  default = "webserver"
}

variable "inbound_ports" {
  description = "This is the ports open for inbound trafic"
  type        = list(string)
  default     = ["80"]
}

variable "distro_version" {
  type    = string
  default = "24.04"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
