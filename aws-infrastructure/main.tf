terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-s3-state-yv"
    key = ""
    region = "us-east-1"
    
  }
}


provider "aws" {
  region     = var.region
}

resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
}