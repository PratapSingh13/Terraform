variable "elasticIP" {
  type        = string
  default     = "eipalloc-019f7b5eed6490f70"
  description = "This is ElasticIP will bound with NAT"
}

variable "PrivateSubnetID" {
  type = string
}

variable "nameNAT" {
  type        = string
  default     = "NAT-temp"
  description = "This is for NAT name"
}

