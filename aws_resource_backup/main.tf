### Here's an example of how to create an EBS snapshot resource in Terraform:
### To create backups or snapshots of EBS volumes associated with your EC2 instances using Terraform, 
# you would typically use the aws_ebs_snapshot resource


resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = "vol-07b9f8e7277bbc5f4"
  storage_tier = "standard"  # Replace with your EBS volume ID
  
  tags = {
    Name = "MyBackup-YV"
  }
}

resource "aws_backup_plan" "example" {
  name = "my-backup-plan"
  rule {
    rule_name         = "daily-backup"
    target_vault_name = "my-backup-vault"
    schedule          = "cron(0 12 * * ? *)"
    start_window      = 360
  }
}

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


# Enabling versioning backup for a S3 bucket.

resource "aws_s3_bucket" "example_bucket" {
  bucket = "your-bucket-name"

  versioning {
    enabled = true
  }
}
