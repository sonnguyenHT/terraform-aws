resource "aws_security_group" "allow_ssh" {
  provider    = aws
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "allow_icmp" {
  name = "allow_icmp"
  description = "Allow ICMP inbound traffic"
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "allow_icmp"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp" {
  security_group_id = aws_security_group.allow_icmp.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port = -1
  to_port = -1
}

resource "aws_security_group" "efs" {
  name = "efs"
  description = "EFS security group"
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "efs"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_private_subnet_0" {
  security_group_id = aws_security_group.efs.id
  cidr_ipv4 = module.vpc.private_subnets_cidr_blocks[0]
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
}

resource "aws_vpc_security_group_ingress_rule" "allow_private_subnet_1" {
  security_group_id = aws_security_group.efs.id
  cidr_ipv4 = module.vpc.private_subnets_cidr_blocks[1]
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
}

resource "aws_vpc_security_group_ingress_rule" "allow_private_subnet_2" {
  security_group_id = aws_security_group.efs.id
  cidr_ipv4 = module.vpc.private_subnets_cidr_blocks[2]
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
}