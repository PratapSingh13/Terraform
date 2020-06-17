provider "aws" {
    profile    = "default"
    region     = var.region
}

# Create VPC
resource "aws_vpc" "My_VPC" {
    cidr_block           = var.vpcCIDRBlock
    instance_tenancy     = var.instanceTenancy
    enable_dns_support   = var.dnsSupport
    enable_dns_hostnames = var.dnsHostNames

    tags = {
        Name = var.vpcName
    }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Creating Public Subnets
resource "aws_subnet" "Public-Subnet-1" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = var.CIDRBlock-1
    map_public_ip_on_launch = var.mapPublicIP

    tags = {
        Name = var.Public_Subnet_Name-1
    }

    availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "Public-Subnet-2" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = var.CIDRBlock-2
    map_public_ip_on_launch = var.mapPublicIP

    tags = {
        Name = var.Public_Subnet_Name-2
    }
    
    availability_zone = data.aws_availability_zones.available.names[1]
}

/*
# Creating Private Subnets
resource "aws_subnet" "Private-Subnet-1" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = var.privCIDRBlock-1

    tags = {
        Name = var.Private_Subnet_Name-1
    }
    
    availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "Private-Subnet-2" {
    vpc_id                  = aws_vpc.My_VPC.id
    cidr_block              = var.privCIDRBlock-2

    tags = {
        Name = var.Private_Subnet_Name-2
    }
    
    availability_zone = data.aws_availability_zones.available.names[0]
}
*/

# Creating IGW
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.My_VPC.id

  tags = {
      Name = var.InternetGateWay
  }
}

/*
# Creating NAT Gateway
resource "aws_nat_gateway" "NAT" {
  allocation_id = var.elasticIP
  subnet_id     = aws_subnet.Public-Subnet-1.id

  tags = {
      Name = var.natName
  }
}
*/

# Creating Route-Table for Public Subnet
resource "aws_route_table" "Public-Route" {
  vpc_id = aws_vpc.My_VPC.id

  tags   = {
    Name = var.publicRouteTableName
  }

  route {
      cidr_block = var.destinationCIDR
      gateway_id = aws_internet_gateway.IGW.id
  }
}

/*
# Creating Route-Table for Private Subnet
resource "aws_route_table" "Private-Route" {
    vpc_id = aws_vpc.My_VPC.id

    tags   = {
      Name = var.privateRouteTableName
    }

    route {
        cidr_block     =  var.destinationCIDR
        nat_gateway_id = aws_nat_gateway.NAT.id
    }
}
*/

# Public Route-Table association
resource "aws_route_table_association" "Public-Association-1" {
  route_table_id = aws_route_table.Public-Route.id
  subnet_id      = aws_subnet.Public-Subnet-1.id
}

resource "aws_route_table_association" "Public-Association-2" {
  route_table_id = aws_route_table.Public-Route.id
  subnet_id      = aws_subnet.Public-Subnet-2.id
}

/*
# Private Route-Table association
resource "aws_route_table_association" "Private-Association-1" {
  route_table_id = aws_route_table.Private-Route.id
  subnet_id      = aws_subnet.Private-Subnet-1.id
}

resource "aws_route_table_association" "Private-Association-2" {
  route_table_id = aws_route_table.Private-Route.id
  subnet_id      = aws_subnet.Private-Subnet-2.id
}
*/

# Security-Group
resource "aws_security_group" "My_Security_Group" {
  vpc_id      = aws_vpc.My_VPC.id
  name        = "My_VPC_Security_Group"
  description = "This is my VPC Security Group"

# Ingress Security Port 80
  ingress {
  cidr_blocks       = var.ingressCIDRBlock
  from_port         = var.ingress_from_Port
  to_port           = var.ingress_to_Port
  protocol          = var.ingressProtocol
 }

# Ingress Security Port
  ingress {
  cidr_blocks = var.ingressCIDRBlock
  from_port   = var.ingressSSHfromPort
  to_port     = var.ingressSSHtoPort
  protocol    = var.protocol
}

# All OutBound access
  egress {
  cidr_blocks       = var.egressCIDRBlock
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egressProtocol
 }
}

# Creating Launch Configuration for Auto-Scaling
resource "aws_launch_configuration" "LaunchConfig" {
  name_prefix     = "LC"

  image_id        = var.image
  instance_type   = var.instance_type
  key_name        = var.key

  security_groups = [aws_security_group.My_Security_Group.id]
  associate_public_ip_address = var.publicIPAssociaton

  /*user_data = <<USER_DATA
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install -y nginx
  sudo systemctl start nginx
  sudo systemctl enable nginx
  USER_DATA*/

  user_data = <<USER_DATA
  #!/bin/bash
  touch /tmp/file.txt
  USER_DATA

  lifecycle {
    create_before_destroy = true
  }
}

# Creating Load-Balancer
# Creating Load-Balancer Security-group
resource "aws_security_group" "elb_SG" {
  name        = "elb"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id      = aws_vpc.My_VPC.id

  ingress {
    from_port   = var.ingress_from_Port
    to_port     = var.ingress_to_Port
    protocol    = var.ingressProtocol
    cidr_blocks = var.ingressCIDRBlock
  }

  egress {
    from_port       = var.egress_from_port
    to_port         = var.egress_to_port
    protocol        = var.egressProtocol
    cidr_blocks     = var.egressCIDRBlock
  }
  
}

resource "aws_elb" "ELB" {
  name = "aws-elb"
  security_groups = [aws_security_group.elb_SG.id]
  subnets = [
    aws_subnet.Public-Subnet-1.id,
    aws_subnet.Public-Subnet-2.id
  ]
  cross_zone_load_balancing   = var.crossZoneBalancing
  
  health_check {
    healthy_threshold   = var.healthyThreshold
    unhealthy_threshold = var.unhealthyThreshold
    timeout             = var.timeout
    interval            = var.interval
    target              = var.target
  }
  listener {
    lb_port           = var.lb_port
    lb_protocol       = var.lb_protocol
    instance_port     = var.instance_port
    instance_protocol = var.instance_protocol
  }
}

# Creating Auto Scaling Group
resource "aws_autoscaling_group" "ASG" {
  name                 = "asg"
  #vpc_id               = aws_vpc.My_VPC.id
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1

  health_check_type    = var.healthCheckType
  load_balancers       = [aws_elb.ELB.id]

  launch_configuration = aws_launch_configuration.LaunchConfig.id
  
  vpc_zone_identifier  = [
    aws_subnet.Public-Subnet-1.id,
    aws_subnet.Public-Subnet-2.id
  ]
  
  depends_on = [aws_elb.ELB, aws_subnet.Public-Subnet-1, aws_subnet.Public-Subnet-2]
 
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "asg_policy_up" {
  name                   = "asg-policy-up"
  scaling_adjustment     = var.scalingIncrease
  adjustment_type        = var.adjustmentType
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.ASG.name
  depends_on             = [aws_autoscaling_group.ASG]
}

resource "aws_autoscaling_policy" "asg_policy_down" {
  name = "asg-policy-down"
  scaling_adjustment     = var.scalingDecrease
  adjustment_type        = var.adjustmentType
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.ASG.name
  depends_on             = [aws_autoscaling_group.ASG]
}

/*resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = var.metricName
  namespace           = "AWS/EC2"
  period              = var.period
  statistic           = var.stats
  threshold           = var.Threshold

  dimensions {
    autoscaling_group_name = aws_autoscaling_group.web.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.web_policy_up.arn]
}
*/
