# Associating Route-Table with Private
resource "aws_route_table_association" "Private-AZ-A" {
  subnet_id      = var.PrivateSubnetID
  route_table_id = var.route_table_id
  #depends_on     = [aws_default_route_table.Private_Route, aws_subnet.Private-Subnet]
}
