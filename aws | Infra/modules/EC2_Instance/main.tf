data "aws_availability_zones" "available" {
  state = "available"
}

# Creating EC2 Instance
resource "aws_instance" "ubuntu" {
  ami                         = var.ami_ID
  instance_type               = var.instanceType
  associate_public_ip_address = true
  availability_zone           = data.aws_availability_zones.available.names[0]
  count                       = var.instanceCount
  subnet_id                   = var.subnet_ID
  #vpc_id                     = "${aws_vpc.My_VPC.id}"
  user_data                   = var.userData
  tenancy                     = var.tenancy
  monitoring                  = var.monitoring
  #ipv6_addresses             = var.ipv6_address
 #key_name                    = aws_key_pair.generated_key.key_name
  security_groups             = var.security_group

  tags = {
    Name = var.InstanceName
  }
}