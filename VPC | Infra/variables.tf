variable "access_key" {
  default = "*******************"
}

variable "secret_key" {
  default = "***********************************"
}

variable "region" {
  default = "ap-south-1"
}

variable "availabilityZone" {
  default = "ap-south-1a"
}


variable "instanceTenancy" {
  default = "default"
}

variable "dnsSupport" {
  default = true
}

variable "dnsHostNames" {
  default = true
}

variable "vpcCIDRBlock" {
  default = "10.0.0.0/16"
}

variable "subnetCIDRBlock" {
  default = "10.0.1.0/24"
}

variable "destinationCIDRBlock" {
  default = "0.0.0.0/0"
}

variable "ingressCIDRBlock" {
  type = list
  default = [ "0.0.0.0/0" ]
}
variable "engressCIDRBlock" {
  type = list
  default = [ "0.0.0.0/0" ]
}

variable "mapPublicIP" {
  default = true
}



