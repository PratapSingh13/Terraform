variable "region" {
  default = "ap-south-1"
}

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

variable "CIDRBlock-1" {
    type        = string
    default     = "10.0.0.0/24"
    description = "The CIDR for PublicSubnet-1"
}

variable "mapPublicIP" {
    type    = bool
    default = true
}

variable "Public_Subnet_Name-1" {
    type        = string
    default     = "PublicSubnet-1"
    description = "Name of our Public Subnet-1"
}

variable "CIDRBlock-2" {
    type        = string
    default     = "10.0.1.0/24"
    description = "The CIDR for PublicSubnet-1"
}

variable "Public_Subnet_Name-2" {
    type        = string
    default     = "PublicSubnet-2"
    description = "Name of our Public Subnet-2"
}
/*
variable "privCIDRBlock-1" {
    type        = string
    default     = "10.0.2.0/24"
    description = "The CIDR for PrivateSubnet-1"
}

variable "Private_Subnet_Name-1" {
    type        = string
    default     = "PrivateSubnet-1"
    description = "Name of our Private Subnet-1"
}

variable "privCIDRBlock-2" {
    type        = string
    default     = "10.0.3.0/24"
    description = "The CIDR for PrivateSubnet-2"
}

variable "Private_Subnet_Name-2" {
    type        = string
    default     = "PrivateSubnet-2"
    description = "Name of our Private Subnet-2"
}
*/
variable "InternetGateWay" {
    type        = string
    default     = "IGW-temp"
    description = "Name for our Internet Gateway"
}
/*
variable "natName" {
    type        = string
    default     = "NAT-temp"
    description = "Name for our NAT"
}


variable "elasticIP" {
    type        = string
    default     = "eipalloc-040a1bf771b0686e8"
    description = "This is ElasticIP will bound with NAT"
}
*/

variable "publicRouteTableName" {
    type        = string
    default     = "Public-Route"
    description = "A Route Table for Public Subnet"
}

/*
variable "privateRouteTableName" {
    type        = string
    default     = "Private-Route"
    description = "A Route Table for Private Subnet"
}
*/
variable "destinationCIDR" {
    type        = string
    default     = "0.0.0.0/0"
    description = "This is Public CIDR"
}

# Variables for Security Group
# Variables for Port 80
variable "ingressCIDRBlock" {
    type    = list
    default = [ "0.0.0.0/0" ]
}

variable "ingress_from_Port" {
    default = "80"
}

variable "ingress_to_Port" {
    default = "80"
}

variable "ingressProtocol" {
    default = "tcp"
}

# Variables for Port 22
variable "ingressSSHfromPort" {
    default = "22"
}

variable "ingressSSHtoPort" {
    default = "22"
}

variable "protocol" {
    default = "tcp"
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

# Variables for Launch-Configuration
variable "image" {
    type        = string
    default     = "ami-0b44050b2d893d5f7"
    description = "This is ami-imageID of Ubuntu Server 18.04 LTS"
}

variable "instance_type" {
    type        = string
    default     = "t2.micro"
    description = "Selecting t2.micro type of instance"
}

variable "key" {
    type        = string
    default     = "ASGKEY"
    description = "Selecting key-pair"
}

variable "publicIPAssociaton" {
    type    = bool
    default = true
}

# Variables for ELB
variable "crossZoneBalancing" {
    type    = bool
    default = true
}

# Variables for Health-Check of ELB
variable "healthyThreshold" {
    type    = number
    default = 2
}

variable "unhealthyThreshold" {
    type    = number
    default = 2
}

variable "timeout" {
    type    = number
    default = 3
}

variable "interval" {
    type    = number
    default = 30
}

variable "target" {
    type    = string
    default = "HTTP:80/"
}

# Variables for Listener of ELB
variable "lb_port" {
    type    = number
    default = 80
}

variable "lb_protocol" {
    type    = string
    default = "http"
}

variable "instance_port" {
    type    = number
    default = 80
}

variable "instance_protocol" {
    type    = string
    default = "http"
}

# Variables for Auto Scaling Group
variable "minimumSize" {
    type    = number
    default = 1
}

variable "maximumSize" {
    type    = number
    default = 4
}

variable "capacity" {
    type    = number
    default = 2
}

variable "healthCheckType" {
    type    = string
    default = "ELB"
}

# Variables for Auto-Scaling Policy
variable "scalingIncrease" {
    type    = number
    default = 1
}

variable "adjustmentType" {
    type    = string
    default = "ChangeInCapacity"
}

variable "cooldown" {
    type    = number
    default = 300
}

variable "scalingDecrease" {
    default = -1
}

/*# Variables for CloudWatch metric alarm
variable "metricName" {
    type    = string
    default = "CPUUtilization"
}

variable "period" {
    type    = number
    default = 120
}

variable "stats" {
    type    = string
    default = "Average"
}

variable "Threshold" {
    type    = number
    default = 70
}
*/

