provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

# Create VPC
resource "aws_vpc" "My_VPC" {
    cidr_block           = "${var.vpcCIDRBlock}"
    instance_tenancy     = "${var.instanceTenancy}"
    enable_dns_support   = "${var.dnsSupport}"
    enable_dns_hostnames = "${var.dnsHostNames}"

    tags = {
        Name = "VPC-temp"
    }
}

# Create Subnet
resource "aws_subnet" "My_VPC_Subnet" {
    vpc_id                  = "${aws_vpc.My_VPC.id}"
    cidr_block              = "${var.subnetCIDRBlock}"
    map_public_ip_on_launch = "${var.mapPublicIP}"
    availability_zone       = "${var.availabilityZone}"

    tags = {
        Name = "My VPC Subnet"
    }
}

# Create the Security Group
resource "aws_security_group" "My_VPC_Security_Group" {
    vpc_id      = "${aws_vpc.My_VPC.id}"
    name        = "My VPC Security Group"
    description = "My VPC Security Group"

    # Allow Ingress of port 22
    ingress {
        cidr_blocks = "${var.ingressCIDRBlock}"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
    }

    # Allow egress of all ports
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name        = "My VPC Security Group"
        description = "My VPC Security Group"
    }
}

# Create VPC NACL
resource "aws_network_acl" "My_VPC_Security_ACL" {
    vpc_id     = "${aws_vpc.My_VPC.id}"
    subnet_ids = "${aws_subnet.My_VPC_Subnet.id}"

    # Allow Ingress port 22
    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "${var.destinationCIDRBlock}"
        from_port  = 80
        to_port    = 80
    }

    # Allow Ingress ephemeral ports
    ingress {
        protocol   = "tcp"
        rule_no    = 300
        action     = "allow"
        cidr_block = "${var.destinationCIDRBlock}"
        from_port  = 22
        to_port    = 22
    }

    # Allow egress port 80
    egress {
        protocol    = "tcp"
        rule_no     = 200
        action      = "allow"
        cidr_block  = "${var.destinationCIDRBlock}"
        from_port   = 80
        to_port     = 80
    }

    # Allow egress ephemeral ports
    egress {
        protocol    = "tcp"
        rule_no     = 300
        action      = "allow"
        cidr_block  = "${var.destinationCIDRBlock}"
        from_port   = 1024
        to_port     = 65535
    }

    tags = {
        Name = "My VPC ACL"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "My_VPC_IGW" {
    vpc_id = "${aws_vpc.My_VPC.id}"
    tags = {
        Name = "My VPC IGW"
    }
}

# Create Route Table
resource "aws_route_table" "My_VPC_route_table" {
    vpc_id = "${aws_vpc.My_VPC.id}"
    tags = {
        Name = "My VPC Route Table"
    }
}

# Create Internet Access
resource "aws_route" "My_VPC_internet_access" {
    route_table_id         = "${aws_route_table.My_VPC_route_table.id}"
    destination_cidr_block = "${var.destinationCIDRBlock}"
    gateway_id             = "${aws_internet_gateway.My_VPC_IGW.id}"
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association" {
    subnet_id      = "${aws_subnet.My_VPC_Subnet.id}"
    route_table_id = "${aws_route_table.My_VPC_route_table.id}"
}



