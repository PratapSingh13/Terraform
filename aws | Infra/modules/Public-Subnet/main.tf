data "aws_availability_zones" "available" {
  state = "available"
}

# Creating Public Subnet 
resource "aws_subnet" "Public-Subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.Public_Subnet_CIDRBlock
  map_public_ip_on_launch = var.mapPublicIP

  tags = {
      Name = var.Public_Subnet_Name
  }

  availability_zone = data.aws_availability_zones.available.names[0]
}

