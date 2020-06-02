variable "ami_ID" {
  type    = string
  default = "ami-0b44050b2d893d5f7"
}

variable "instanceType" {
  type    = string
  default = "t2.micro"
}

variable "associate_publicIP" {
  type    = bool
  default = false
}


variable "instanceCount" { 
  type       = number
  default    = 1
  description = "Number of Instance to launch"
}

variable "userData" {
  type    = string
  default = ""
}

variable "tenancy" {
  type        = string
  default     = "default"
  description = "This is the Tenancy of the Instance"
}

variable "monitoring" {
  type        = bool
  default     = false
  description = "This is regarding Monitoring of our Instance"
}

variable "ipv6_address" {
  type        = string
  default     = ""
  description = "To Specify IPv6 addresses"
}

variable "security_group" {
  type = list
}

variable "subnet_ID" {
  type = string
}

variable "InstanceName" {
  type        = string
  default     = "Linux_TF"
  description = "Providing name for our EC2 instance"
}
