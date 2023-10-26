### Example of how to create a basic Amazon Aurora MySQL database using Terraform


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}


### Provides an RDS DB subnet group resource
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name        = "aurora-subnet-group"
  description = "Aurora subnet group"
  subnet_ids  = ["subnet-0a135ebade0072a07", "subnet-088463813c6744d33"]  # Replace with your subnet IDs
}


### Provides a security group resource.
resource "aws_security_group" "aurora_db_sg" {
  name        = "aurora-db-sg"
  description = "Aurora database security group"
  vpc_id      = "vpc-0ba0c613b634a5b11"

  # Define security group rules for database access
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict this as needed for security
  }
}



resource "aws_db_parameter_group" "aurora_db_parameter_group" {
  name = "aurora-db-parameter-group"
  family = "aurora-mysql5.7"
  description = "Aurora database parameter group"
}


resource "aws_db_instance" "aurora_db" {
  allocated_storage    = 8
  storage_type         = "gp2"
  engine               = "aurora"
  engine_version       = "5.7.mysql_aurora.2.03.2"
  instance_class       = "db.t3.micro"
  db_name              = "aurora-instance"
  username             = "yagna"
  password             = "password"
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids = [aws_security_group.aurora_db_sg.id]
  parameter_group_name  = aws_db_parameter_group.aurora_db_parameter_group.name

  # Optional: Additional configuration settings, like backup retention, can be added here
}

output "aurora_endpoint" {
  value = aws_db_instance.aurora_db.endpoint
}
