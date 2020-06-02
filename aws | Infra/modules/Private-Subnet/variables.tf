variable "vpc_id" {
  #type        = string
  #default     = 
  description  = "Providing VPC_ID for Public-Subnet"
}

variable "Private_Subnet_CIDRBlock" {
  type        = string
  default     = "10.0.2.0/24"
  description = "The CIDR for Private Subnet"
}

variable "Private_Subnet_Name" {
    type        = string
    default     = "Private-Subnet"
    description = "Name for our Subnet"
}
