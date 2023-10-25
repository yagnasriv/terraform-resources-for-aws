variable "region" {
description = "default ec2 isntance region"
default   = "us-east-1"
}

variable "ami" {
  description = "instance os type"
  default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
  description = "type of the instance can be t2.nano, t2.micro etc..."
  default = "t2.micro"
}

variable "subnet_id" {
  description = "id of the subnet where the instance will be created"
  default = "subnet-088463813c6744d33"
}

