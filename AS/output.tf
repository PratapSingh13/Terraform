output "vpc_id" {
    value = aws_vpc.My_VPC.id
}

output "subnet_ID-1" {
    value = aws_subnet.Public-Subnet-1.id
}

output "subnet_ID-2" {
    value = aws_subnet.Public-Subnet-2.id
}

/*
output "subnet_ID-3" {
    value = aws_subnet.Private-Subnet-1.id
}

output "subnet_ID-4" {
    value = aws_subnet.Private-Subnet-2.id
}
*/

output "IGW-ID" {
    value = aws_internet_gateway.IGW.id
}

/*
output "NAT-ID" {
    value = aws_nat_gateway.NAT.id
}
*/

output "PublicRouteTable-ID" {
    value = aws_route_table.Public-Route.id
}

/*
output "PrivateRouteTable-ID" {
    value = aws_route_table.Private-Route.id
}
*/

output "SecurityGroup-ID" {
    value = aws_security_group.My_Security_Group.id
}

output "ELB-IP" {
    value = aws_elb.ELB.dns_name
}


