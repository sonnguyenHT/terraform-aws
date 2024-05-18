resource "ec2_instance" "allow_ssh" {
  provider    = aws
  name        = "allow_ssh"
  Description = "Allow SSH inbound traffic"
  vpc         = module.vpc.vpc_id
  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = ec2_instance.allow_ssh.security_group_id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}