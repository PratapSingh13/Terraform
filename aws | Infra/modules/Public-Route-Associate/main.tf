# Associating Route-Table with Public
resource "aws_route_table_association" "Public-Route-Association" {
  subnet_id      = var.PublicSubnetID
  route_table_id = var.route_table_id
 #depends_on     = [aws_route_table.Public-Route, aws_subnet.Public-Subnet]
}