variable "vpc_id" {
  #type        = string
  #default     = 
  description = "Providing VPC_ID for IGW"
}

variable "InternetGateWay" {
  type        = string
  default     = "IGW-temp"
  description = "This is name of our Internet Gateway"
}

