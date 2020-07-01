#!/bin/bash

AWS_REGION="ap-south-1"
VPC_NAME="MY VPC"
VPC_CIDR="10.0.0.0/16"
SUBNET_PUBLIC_CIDR_A="10.0.0.0/24"
SUBNET_PUBLIC_CIDR_B="10.0.1.0/24"
SUBNET_PUBLIC_AZ_A="ap-south-1a"
SUBNET_PUBLIC_AZ_B="ap-south-1b"
SUBNET_PUBLIC_NAME_A="Public-Subnet-A"
SUBNET_PUBLIC_NAME_B="Public-Subnet-B"

# Creating VPC
echo "Creating VPC in ap-south-1 region..."
VPC_ID=$(aws ec2 create-vpc \
--cidr-block $VPC_CIDR \
--query 'Vpc.{VpcId:VpcId}' \
--output text)
echo " VPC ID '$VPC_ID' CREATED in '$AWS_REGION' region"

# Adding name tag to VPC
aws ec2 create-tags \ 
--resources $VPC_ID \ 
--tags Key=Name,Value=My VPC
echo "VPC ID '$VPC_ID' NAMED as '$VPC_NAME'"

# Creating Public Subnet
echo "Creating Public Subnet..."
SUBNET_PUBLIC_A_ID=$(aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block $SUBNET_PUBLIC_CIDR_A \
--availability-zone $SUBNET_PUBLIC_AZ_A \
--query 'Subnet.{SubnetId:SubnetId}' \
--output text) &&
SUBNET_PUBLIC_B_ID=$(aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block $SUBNET_PUBLIC_CIDR_B \
--availability-zone $SUBNET_PUBLIC_AZ_B \
--query 'Subnet.{SubnetId:SubnetId}' \
--output text)
echo " Subnet ID '$SUBNET_PUBLIC_A_ID' CREATED in '$SUBNET_PUBLIC_AZ_A' Availability Zone"
echo " Subnet ID '$SUBNET_PUBLIC_B_ID' CREATED in '$SUBNET_PUBLIC_AZ_B' Availability Zone"

# Enabling Auto-assign Public IP on Public Subnets
aws ec2 modify-subnet-attribute \
--subnet-id $SUBNET_PUBLIC_A_ID \
-- map-public-ip-on-launch &&
aws ec2 modify-subnet-attribute \
--subnet-id $SUBNET_PUBLIC_B_ID \
--map-public-ip-on-launch

# Creating an IGW and attaching to VPC
echo "Creating Internet Gateway"
IGW=$(aws ec2 create-internet-gateway \
--query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
--output text) &&
aws ec2 attach-internet-gateway \
--vpc-id $VPC_ID \
--internet-gateway-id $IGW
echo " Internet Gateway ID '$IGW' CREATED"

# Creating Route Table
echo "Creating Route Table..."
ROUTE_TABLE=$(aws ec2 create-route-table \
--vpc-id $VPC_ID \
--query 'RouteTable.{RouteTableId.RouteTableId}' \
--output text)
echo "  Route Table ID '$ROUTE_TABLE' CREATED."

# Creating route to IGW
aws ec2 create-route \
--route-table-id $ROUTE_TABLE \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id $IGW

# Associating Public Subnets with Route-Table
ROUTE_TABLE_ASSOC_A=$(aws ec2 associate-route-table \
--subnet-id $SUBNET_PUBLIC_A_ID \
--route-table-id $ROUTE_TABLE \
--query 'AssociationId' \
--output text) &&
ROUTE_TABLE_ASSOC_B=$(aws ec2 associate-route-table \
--subnet-id $SUBNET_PUBLIC_B_ID \
--route-table-id $ROUTE_TABLE \
--query 'AssociationId' \
--output text)

# Creating Security Group
aws ec2 create-security-group \
--vpc-id $VPC_ID \
--group-name myvpc-security-group \
--description 'My VPC Security Group'

# Get security group ID's
DEFAULT_SECURITY_GROUP_ID=$(aws ec2 describe-security-groups \
--filters "Name=vpc-id,Values=$VPC_ID" \
--query 'SecurityGroups[?GroupName == `default`].GroupId' \
--output text) &&
CUSTOM_SECURITY_GROUP_ID=$(aws ec2 describe-security-groups \
--filters "Name=vpc-id,Values=$VPC_ID" \
--query 'SecurityGroups[?GroupName == `myvpc-security-group`].GroupId' \
--output text)
 
## Create security group ingress rules
aws ec2 authorize-security-group-ingress \
--group-id $CUSTOM_SECURITY_GROUP_ID \
--ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "Allow SSH"}]}]' &&
aws ec2 authorize-security-group-ingress \
--group-id $CUSTOM_SECURITY_GROUP_ID \
--ip-permissions '[{"IpProtocol": "tcp", "FromPort": 80, "ToPort": 80, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "Allow HTTP"}]}]'
