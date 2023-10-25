### Cross-Region Replication:
### AWS services like S3 and RDS support cross-region replication. 
### This can be used for disaster recovery and data redundancy, ensuring that data is copied to a different AWS region


provider "aws" {
  region = "us-east-1"  # Set your source region
}

resource "aws_s3_bucket" "source_bucket" {
  bucket = "source-bucket-name-yv"
}

provider "aws" {
  alias  = "us-west-2"  # Create an alias for the destination region
  region = "us-west-2"  # Set your destination region
}

resource "aws_s3_bucket" "destination_bucket" {
  provider = aws.us-west-2  # Use the alias to specify the destination region
  bucket   = "destination-bucket-name-yv"
}

resource "aws_s3_bucket_public_access_block" "source_bucket_block" {
  bucket = aws_s3_bucket.source_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "destination_bucket_block" {
  bucket = aws_s3_bucket.destination_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



### Cross Region Replication for AWS RDS 


resource "aws_db_instance" "source_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "source-instance"
  username             = "dbuser"
  password             = "dbpassword"
  publicly_accessible  = false
}

provider "aws" {
  alias  = "us-west-2"  # Create an alias for the destination region
  region = "us-west-2"  # Set your destination region
}

resource "aws_db_instance" "destination_replica" {
  provider             = aws.us-west-2  # Use the alias to specify the destination region
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "destination-replica"
  username             = "dbuser"
  password             = "dbpassword"
  publicly_accessible  = false

  # Specify the source DB instance to replicate from
  aws_db_instance = aws_db_instance.source_instance.id
}
