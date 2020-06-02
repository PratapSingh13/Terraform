# Creating Route-Table for Private Subnet
resource "aws_route_table" "Private-Route" {
  vpc_id = var.vpc_id

  tags = {
      Name = var.privateRouteTableName
  }

  route {
      cidr_block     = var.CIDRBlock
      nat_gateway_id = var.natgateway_id
  }
}