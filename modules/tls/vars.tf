variable "key_name" {
  description = "The name of the key pair to create in AWS"
  type        = string
  default     = "my-key-pair"
}

variable "file_path" {
  description = "The local file path to save the private key"
  type        = string
  default     = "./ssh_key.pem"
}
