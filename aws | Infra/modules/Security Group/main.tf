resource "aws_security_group" "security_group" {
    name = "security group made by terraform"
    vpc_id = var.vpc_id

    ingress {
        from_port   = var.ingress_from_Port
        to_port     = var.ingress_to_Port
        protocol    = var.ingressProtocol
        cidr_blocks = var.ingressCIDRBlock
    }

    egress {
        from_port   = var.egress_from_port
        to_port     = var.egress_to_port
        protocol    = var.egressProtocol
        cidr_blocks = var.egressCIDRBlock
    }
}
