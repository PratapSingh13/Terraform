variable "vpc_id" {
  #type        = string
  #default     = 
  description = "Providing VPC_ID for IGW"
}

variable "ingressCIDRBlock" {
  type    = list
  default = [ "0.0.0.0/0" ]
}

variable "ingress_from_Port" {
  type    = number
  default = "22"
}

variable "ingress_to_Port" {
  type    = number
  default = "22"
}

variable "ingressProtocol" {
  type    = string
  default = "tcp"
}


variable "egressCIDRBlock" {
  type    = list
  default = [ "0.0.0.0/0" ]
}

variable "egress_from_port" {
  type    = number
  default =  "0"
  
}

variable "egress_to_port" {
  type    = number
  default = "-1"
}

variable "egressProtocol" {
  type    = string
  default = "tcp"
}
