module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "sonnguyen"
  monitoring             = true
  vpc_security_group_ids = []
  subnet_id              = module.vpc.public_subnets[0] # Use public subnet from the VPC module
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}