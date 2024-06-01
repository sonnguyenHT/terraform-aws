resource "aws_launch_template" "foo" {
  name = "foo"

#   block_device_mappings {
#     device_name = "/dev/sdf"

#     ebs {
#       volume_size = 20
#     }
#   }

#   capacity_reservation_specification {
#     capacity_reservation_preference = "open"
#   }

#   cpu_options {
#     core_count       = 1
#     threads_per_core = 1
#   }

  credit_specification {
    cpu_credits = "standard"
  }

#   disable_api_stop        = true
#   disable_api_termination = true

#   ebs_optimized = true
#   block_device_mappings {
#     ebs {
#       volume_type = "gp2"
#       volume_size = "1"
#     }
#   }
#   elastic_gpu_specifications {
#     type = "test"
#   }

#   elastic_inference_accelerator {
#     type = "eia1.medium"
#   }

#   iam_instance_profile {
#     name = "test"
#   }

  image_id = "ami-003c463c8207b4dfa"

#   instance_initiated_shutdown_behavior = "terminate"

#   instance_market_options {
#     market_type = "spot"
#   }

  instance_type = "t2.micro"

#   kernel_id = "test"

  key_name = "sonnguyen"

#   license_specification {
#     license_configuration_arn = "arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef"
#   }

#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#     http_put_response_hop_limit = 1
#     instance_metadata_tags      = "enabled"
#   }

#   monitoring {
#     enabled = true
#   }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id = module.vpc.public_subnets[0]
  }

#   placement {
#     availability_zone = "us-west-2a"
#   }

#   ram_disk_id = "test"

#   vpc_security_group_ids = ["sg-12345678"]
#   security_group_names = []
#   vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

#   user_data = filebase64("${path.module}/example.sh")
}

output "aws_launch_template_id" {
  value = aws_launch_template.foo.id 
}