data "aws_availability_zones" "available" {
  state = "available"
}
# Creating Private Subnet
resource "aws_subnet" "Private-Subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.Private_Subnet_CIDRBlock

  tags = {
      Name = var.Private_Subnet_Name
  }
  availability_zone = data.aws_availability_zones.available.names[0]
}
