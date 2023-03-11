provider "aws" {
  region = "us-east-1"
}

terraform {

  required_version = "~> 1.2.6"

  required_providers {
    aws  = "~> 3.74.3"
  }

  backend "s3" {
    bucket = "../.."
    key    = "../.."
    region = "us-east-1"
  }
}

################################################################################
# VPC
################################################################################

/module "vpc" {
  source = "./modules/terraform-aws-modules/terraform-aws-vpc"
  name   = "${var.project}-${var.environment}"
  cidr   = "${lookup(var.cidr_block, var.environment)}.0.0/16"
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  azs = [
        "${lookup(var.region, var.environment)}a",
        "${lookup(var.region, var.environment)}b",
    ]
}

