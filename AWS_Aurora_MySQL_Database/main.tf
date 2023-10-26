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


# ### Provides an RDS DB subnet group resource
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

### Use aws_db_instance when You need a standalone database instance (e.g., Amazon RDS for MySQL, PostgreSQL, SQL Server) 
### and don't require the advanced features of an Aurora cluster.
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


### Use aws_rds_cluster when: You require a highly available database with automatic failover. 
### Aurora clusters are designed for this purpose and provide better resilience.
### If Your application demands read scalability and the ability to add read replicas as needed. Aurora clusters offer this capability.
### If You want a distributed, fault-tolerant database solution with data replication across multiple Availability Zones.

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["us-east-1a", "us-east-ib"]
  database_name           = "aurora-mysql-cluster-yv"
  master_username         = "yagna"
  master_password         = "password"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "my-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.12"
  master_username         = "dbadmin"
  master_password         = "dbpassword"
  database_name           = "aurora-mysql-db-yv"
  port                    = 3306
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  availability_zones      = ["us-east-1a", "us-east-1b"]

  scaling_configuration {
    auto_pause                = true
    max_capacity              = 16
    min_capacity              = 2
    seconds_until_auto_pause  = 300
  }

  vpc_security_group_ids = [aws_security_group.aurora_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.aurora_subnet_group.name
}
