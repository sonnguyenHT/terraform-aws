# output "aws_launch_template_id" {
#   value = aws_launch_template.foo.id 
# }

output "test" {
  value = module.vpc.public_subnets[0]
}