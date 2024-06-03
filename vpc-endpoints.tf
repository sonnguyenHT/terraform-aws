# ec2 instance connect endpoint 
resource "aws_ec2_instance_connect_endpoint" "example" {
  subnet_id = module.vpc.private_subnets[0]
  security_group_ids = [resource.aws_security_group.allow_ssh.id]
}