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