variable "vpcCIDRBlock" {
  type        = string
  default     = "10.0.0.0/16"
  description = "This is the CIDR Block for VPC"
}

variable "instanceTenancy" {
  type        = string
  default     = "default"
  description = "Taking Instance Tenancy"
}

variable "dnsSupport" {
  type        = bool
  default     = true
  description = "Want to take DNS Support"
}

variable "dnsHostNames" {
  type        = bool
  default     = true
  description = "Want to take DNS HostName"
}

variable "vpcName" {
  type        = string
  default     = "vpc-temp"
  description = "This is your VPC name"
}



