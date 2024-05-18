terraform {
  required_version = ">= 1.18.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-sonnguyen"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform_state"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}