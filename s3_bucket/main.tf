provider "aws" {
  region = "us-east-1"  # Set your source region
}

resource "aws_s3_bucket" "source_bucket" {
  bucket = "source-bucket-name"
}

provider "aws" {
  alias  = "us-west-2"  # Create an alias for the destination region
  region = "us-west-2"  # Set your destination region
}

resource "aws_s3_bucket" "destination_bucket" {
  provider = aws.us-west-2  # Use the alias to specify the destination region
  bucket   = "destination-bucket-name"
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

resource "aws_s3_bucket_replication" "example" {
  role  = "arn:aws:iam::123456789012:role/ReplicationRole"  # Specify your replication role ARN

  source_bucket      = aws_s3_bucket.source_bucket.id
  destination_bucket = aws_s3_bucket.destination_bucket.id

  rules = [
    {
      id     = "allObjects",
      status = "Enabled",
      prefix = "",
    },
  ]
}
