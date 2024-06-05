module "efs" {
  source = "terraform-aws-modules/efs/aws"

  # File system
  name           = "example"
  creation_token = "example-token"
  encrypted      = true
  kms_key_arn    = aws_kms_key.example.arn

  # performance_mode                = "maxIO"
  # NB! PROVISIONED TROUGHPUT MODE WITH 256 MIBPS IS EXPENSIVE ~$1500/month
  #throughput_mode                 = "provisioned"
  throughput_mode = "elastic"
  # provisioned_throughput_in_mibps = 256

  lifecycle_policy = {
    transition_to_ia = "AFTER_30_DAYS"
    transition_to_archive = "AFTER_90_DAYS"
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  # File system policy
  attach_policy                      = true
  bypass_policy_lockout_safety_check = false
  deny_nonsecure_transport = true
  policy_statements = [
    {
      sid     = "EFS policy"
      actions = ["elasticfilesystem:ClientMount"]
      principals = [
        {
          type        = "AWS"
          identifiers = [aws_iam_role.role.arn]
        }
      ]
    }
  ]

  # Mount targets / security group
  mount_targets = {
    "ap-southeast-1a" = {
      subnet_id = module.vpc.private_subnets[0]
    #   ip_address = ""
    }
    "ap-southeast-1b" = {
      subnet_id = module.vpc.private_subnets[1]
    }
    "ap-southeast-1c" = {
      subnet_id = module.vpc.private_subnets[2]
    }
  }
  # security group
  create_security_group = true
  security_group_description = "EFS security group"
  security_group_vpc_id      = module.vpc.vpc_id
  security_group_rules = {
    vpc = {
      # relying on the defaults provdied for EFS/NFS (2049/TCP + ingress)
      description = "NFS ingress from VPC private subnets"
      #cidr_blocks = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }

  # Access point(s)
  access_points = {
    posix_example = {
      name = "posix-example"
      posix_user = {
        gid            = 1001
        uid            = 1001
        secondary_gids = [1002]
      }
      root_directory = {
        path = "/"
        creation_info = {
          owner_gid   = 1001
          owner_uid   = 1001
          permissions = "755"
        }
      }

      tags = {
        Additionl = "yes"
      }
    }
    # root_example = {
    #   root_directory = {
    #     path = "/example"
    #     # creation_info = {
    #     #   owner_gid   = 1001
    #     #   owner_uid   = 1001
    #     #   permissions = "755"
    #     # }
    #   }
    # }
  }

#   # Backup policy
#   enable_backup_policy = true

  # Replication configuration
#   create_replication_configuration = true
#   replication_configuration_destination = {
#     region = "eu-west-2"
#   }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}