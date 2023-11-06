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

### Create a Dynamo DB Table Resource 

resource "aws_dynamodb_table" "example" {
  name           = "ExampleTable-yv"
  billing_mode   = "PAY_PER_REQUEST"  # Use "PROVISIONED" for provisioned throughput
  hash_key       = "id"
  range_key      = "timestamp"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }
}


### Create an AWS Lambda function Resource 

resource "aws_lambda_function" "example" {

  function_name = "ExampleFunction-yv"
  handler      = "index.handler"
  runtime      = "nodejs18.x"
  role         = aws_iam_role.example.arn

  s3_bucket = "s3-bucker-for-dynamodb"
  s3_key    = "lambda.zip"

}

data "archive_file" "lambda" {
  type        = "zip"
  source_file  = "lambda.js"
  output_path = "lambda.zip"
}


### Create an AWS IAM Role 

resource "aws_iam_role" "example" {
  name = "ExampleRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "dynamodb" {
  name        = "DynamoDBPolicy"
  description = "IAM policy for DynamoDB access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "dynamodb:DescribeStream",
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:ListStreams",
      ],
      Effect   = "Allow",
      Resource = aws_dynamodb_table.example.arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb" {
  policy_arn = aws_iam_policy.dynamodb.arn
  role       = aws_iam_role.example.name
}


### DEfine DynamoDB Stream ARN

data "aws_dynamodb_table" "example" {
  name = aws_dynamodb_table.example.name
}

output "dynamodb_stream_arn" {
  value = aws_dynamodb_table.example.stream_arn
}

