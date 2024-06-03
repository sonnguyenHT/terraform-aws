output "test" {
  value = module.vpc.public_subnets[0]
}