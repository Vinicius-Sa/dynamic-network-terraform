##################################             ###############################
#                                      ENV                                   #
##################################             ###############################
variable "environment" {
  type = string
  description = "Deployment environment, Options: dissaster-reccovery, dev"
}

variable "project" {
  type = string
  description = "Desired name for product resources identification."
}

variable "service_name" {
  type = string
  description = "Service name description."
}


##################################             ###############################
#                                  DYNAMIC VPC                               #
##################################             ###############################
variable "cidr_block"{
  type = map
  default = {
    symptest            = "172.22"
    dev                 = "172.24"
  }
}

locals {
  private_subnets = [
        "${lookup(var.cidr_block, var.environment)}.1.0/24",
        "${lookup(var.cidr_block, var.environment)}.2.0/24"
    ]
  public_subnets          = [
        "${lookup(var.cidr_block, var.environment)}.11.0/24",
        "${lookup(var.cidr_block, var.environment)}.12.0/24",
    ]
}

variable "region" {
  type =map(string)
  description = "map region per environment"
  default = {
    "prod"               = "<region>1"
    "dev"                = "<region>2"
  }
}
