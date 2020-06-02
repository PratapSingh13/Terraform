provider "aws" {
  access_key = var.accessKey
  secret_key = var.secretKey
  region     = var.region
}

# Module for VPC creation
module "VPC_Module" {
  source                 = "/home/opstree/Desktop/demo/aws/modules/vpc/"
  vpcCIDRBlock           = "10.0.0.0/16"
  instanceTenancy        = "default"
  dnsSupport             = true
  dnsHostNames           = true
  vpcName                = "vpc-temp"
}

# Module for Internet Gateway
module "IGW_Module" {
  source          = "/home/opstree/Desktop/demo/aws/modules/IGW/"
  vpc_id          = module.VPC_Module.vpc_ID
  InternetGateWay = "IGW-temp"
  
}

# Module for Public Subnet
module "Public_Subnet_Module" {
  source                  = "/home/opstree/Desktop/demo/aws/modules/Public-Subnet/"
  vpc_id                  = module.VPC_Module.vpc_ID
  Public_Subnet_CIDRBlock = "10.0.1.0/24"
  mapPublicIP             = true
}

# Module for Private Subnet
module "Private_Subnet_Module" {
  source                   = "/home/opstree/Desktop/demo/aws/modules/Private-Subnet/"
  vpc_id                   = module.VPC_Module.vpc_ID
  Private_Subnet_CIDRBlock = "10.0.2.0/24"
  Private_Subnet_Name      = "Private-Subnet"
}

# Module for NAT Gateway
module "NAT_Module" {
  source          = "/home/opstree/Desktop/demo/aws/modules/NAT-GateWay/"
  PrivateSubnetID = module.Private_Subnet_Module.Private_Subnet_ID
  elasticIP       = "eipalloc-019f7b5eed6490f70"
  nameNAT         = "NAT-temp"
}

# Module for Public Route Table
module "Public_Route_Table_Module" {
  source               = "/home/opstree/Desktop/demo/aws/modules/Public-Route-Table/"
  vpc_id               = module.VPC_Module.vpc_ID
  publicRouteTableName = "Public-Route"
  CIDRBlock            = "0.0.0.0/0"
  gateway_id           = module.IGW_Module.IGW_ID
}

# Module for Private Route Table
module "Private_Route_Table_Module" {
  source = "/home/opstree/Desktop/demo/aws/modules/Private-Route-Table/"
  vpc_id                = module.VPC_Module.vpc_ID
  privateRouteTableName = "Private-Route"
  CIDRBlock             = "0.0.0.0/0"
  natgateway_id         = module.NAT_Module.NGW_ID
}


# Module for Public Route Table Association
module "Association-1" {
  source         = "/home/opstree/Desktop/demo/aws/modules/Public-Route-Associate/"
  PublicSubnetID = module.Public_Subnet_Module.subnet_ID.id
  route_table_id = module.Public_Route_Table_Module.PublicRouteTable_ID
}

# Module for Private Route Table Association
module "Association-2" {
  source          = "/home/opstree/Desktop/demo/aws/modules/Private-Route-Associate/"
  PrivateSubnetID = module.Private_Subnet_Module.Private_Subnet_ID
  route_table_id  = module.Private_Route_Table_Module.PrivateRouteTable_ID
}

module "Security_Module" {
  source = "/home/opstree/Desktop/demo/aws/modules/Security Group/"
  vpc_id            = module.VPC_Module.vpc_ID
  ingress_from_Port = "22"
  ingress_to_Port   = "22"
  ingressProtocol   = "tcp"
  ingressCIDRBlock  = [ "0.0.0.0/0" ]
  egress_from_port  = "0"
  egress_to_port    = "-1"
  egressProtocol    = "tcp"
  egressCIDRBlock   = [ "0.0.0.0/0" ]
  
}

module "key" {
  source    = "/home/opstree/Desktop/demo/aws/modules/Key-Pair/"
  algorithm = "RSA"
  rsa_bits  = 4096
  key_name  = "My-Key"
}


module "Instance_Module" {
  source             = "/home/opstree/Desktop/demo/aws/modules/EC2_Instance/"
  ami_ID             = "ami-0b44050b2d893d5f7"
  instanceType       = "t2.micro"
  associate_publicIP = true
  subnet_ID          = module.Public_Subnet_Module.subnet_ID.id
  instanceCount      = 1
  userData           = ""
  tenancy            = "default"
  monitoring         = false
  #key_name           = module.key.key_pair
 #ipv6_addres        = ""
  security_group     = [module.Security_Module.SecurityGroup_ID]
  InstanceName       = "Linux_TF"
}
