terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {

    bucket = "terraform-s3-state-yv"
    key = "terraform.tfstate"
    region = "us-east-1"
    
  }
}


provider "aws" {
  region     = var.region
}


# Example for Creating AWS EC2 Instance 

resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
}



# Example for Creating a S3 bucket 
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-yv"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }

  # versioning {
  #    enabled = true
  # }

}