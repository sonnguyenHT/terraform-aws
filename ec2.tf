module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  for_each = toset(["one","two"])
  #name = "single-instance"
  name = "instance-${each.key}"
  instance_type = "t2.micro"
  #instance_type          = "c5.large" # this is using when turn on placement group
  key_name               = "sonnguyen"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id              = module.vpc.public_subnets[0] # Use public subnet from the VPC module
  associate_public_ip_address = true
  #placement_group = aws_placement_group.cluster.name
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
