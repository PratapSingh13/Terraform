variable "algorithm" {
  type = string
  default = "RSA"
}

variable "rsa_bits" {
  type    = number
  default = 4096
}


variable "key_name" {
  type        = string
  description = "This is for Key Pair"
}
