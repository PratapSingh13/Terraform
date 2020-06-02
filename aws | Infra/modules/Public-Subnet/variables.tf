variable "vpc_id" {
  #type        = string
  #default     = 
  description = "Providing VPC_ID for Public-Subnet"
}

variable "Public_Subnet_CIDRBlock" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The CIDR for Public Subnet"
}

variable "mapPublicIP" {
  default  = true
  type     = bool
}

variable "Public_Subnet_Name" {
    type        = string
    default     = "Public-Subnet"
    description = "Name for our Subnet"
}
