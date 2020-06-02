variable "vpc_id" {
  #type        = string
  #default     = 
  description  = "Providing VPC_ID for Public-Subnet"
}

variable "publicRouteTableName" {
  type        = string
  default     = "Public-Route"
  description = "This is for name of Public Route Table Name"
}

variable "CIDRBlock" {
  type        = string
  default     = "0.0.0.0/0"
  description = "This is the CIDR Block for Public Route Table"
}

variable "gateway_id" {

}


