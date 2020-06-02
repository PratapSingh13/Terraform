# Creating Route-Table
resource "aws_route_table" "Public-Route" {
  vpc_id = var.vpc_id

  tags = {
      Name = var.publicRouteTableName
  }

  route {
      cidr_block = var.CIDRBlock
      gateway_id = var.gateway_id
  }
}