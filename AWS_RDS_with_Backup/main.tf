provider "aws" {
  region = "us-east-1"
}

# Example: Enabling Automated Backups for an Amazon RDS Database

resource "aws_db_instance" "example" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydatabaseyv"
  username             = "yagna"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = false

  # Enable automated backups
  backup_retention_period = 1  # Retain backups for 1 days
  backup_window           = "03:00-04:00"  # Backup window
}

## It is designed to make it easier to set up, operate, and scale a relational database in the cloud
## AWS RDS supports various database engines, including MySQL, PostgreSQL, Oracle, SQL Server, 
## and Amazon Aurora, which is a MySQL- and PostgreSQL-compatible database engine built by AWS


# Example to provision a single sqldb on AWS without Backup

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mysqldbyv"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "yagna"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}



