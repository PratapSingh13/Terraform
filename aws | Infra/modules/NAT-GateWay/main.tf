# Creating NAT Gateway
resource "aws_nat_gateway" "NAT" {
  allocation_id = var.elasticIP
  subnet_id     = var.PrivateSubnetID

  tags = {
      Name = var.nameNAT
  }
}
