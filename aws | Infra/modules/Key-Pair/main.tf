#resource "tls_private_key" "private_key" {
 # algorithm = var.algorithm
  #rsa_bits  = var.rsa_bits

  #resource "aws_key_pair" "generated_key" {
 # key_name   = var.key_pair
 # public_key = tls_private_key.private_key.public_key_openssh
#}
#}

