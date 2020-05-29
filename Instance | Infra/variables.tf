variable "aws_access_key" {
  default = "********************"
}

variable "aws_secret_key" {
  default = "*******************************************"
}

variable "region" {
  default = "ap-south-1"
}

variable "vpcCIDRBlock" {
  default = "10.0.0.0/16"
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

variable "vpcName" {
  default = "vpc-temp"
}

variable "InternetGateWay" {
  default     = "IGW"
  description = "This is my Internet GateWay name"
}

variable "elasticIP" {
  default     = "eipalloc-019f7b5eed6490f70"
  description = "This is ElasticIP will bound with NAT"
}


variable "Public-Subnet-AZ-A" {
  default     = "10.0.1.0/24"
  description = "The CIDR for Public Subnet"
}

variable "mapPublicIP" {
  default = true
}


variable "subnet-public" {
  default     = "Public-Subnet"
  description = "Name tag for Public Subnet"
}

variable "publicRouteTableName" {
  default     = "Public-Route"
  description = "A Route Table for Public Subnet"
}

variable "Private-Subnet-AZ-A" {
  default     = "10.0.2.0/24"
  description = "The CIDR for Private Subnet"
}

variable "subnet-private" {
  default     = "Private-Subnet"
  description = "Name tag for Private Subnet"
}


variable "privateRouteTableName" {
  default     = "Private-Route"
  description = "A Route Table for Private Subnet"
}

variable "ingressCIDRBlock" {
  type    = list
  default = [ "0.0.0.0/0" ]
}

variable "ingress_from_Port" {
  default = "22"
}

variable "ingress_to_Port" {
  default = "22"
}

variable "ingressProtocol" {
  default = "tcp"
}

variable "ingressType" {
  default = "ingress"
}


variable "egressCIDRBlock" {
  type    = list
  default = [ "0.0.0.0/0" ]
}

variable "egress_from_port" {
  default = "0"
}

variable "egress_to_port" {
  default = "0"
}

variable "egressProtocol" {
  default = "-1"
}

variable "egressType" {
  default = "egress"
}

variable "amiID" {
  default = "ami-0b44050b2d893d5f7"
}

variable "instanceType" {
  default = "t2.micro"
}

variable "instanceCount" { 
  default = 1
  description = "Number of Instance to launch"
}

variable "userData" {
  default = "null"
}

variable "tenancy" {
  default     = "default"
  description = "This is the Tenancy of the Instance"
}

variable "monitoring" {
  default     = false
  description = "This is regarding Monitoring of our Instance"
}

variable "ipv6_address" {
  default     = ""
  description = "To Specify IPv6 addresses"
}


variable "publicInstanceName" {
  default     = "Linux_TF-Pub"
  description = "Providing name for our EC2 instance"
}

variable "privateInstanceName" {
  default     = "Linux_TF-Priv"
  description = "Providing name for our EC2 instance"
}