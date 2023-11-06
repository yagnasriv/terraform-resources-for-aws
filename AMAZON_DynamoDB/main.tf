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

### Terraform Resource for creating DynamoDB

resource "aws_dynamodb_table" "example" {
  name           = "ExampleTable"
  billing_mode   = "PAY_PER_REQUEST"  # Use "PROVISIONED" for provisioned throughput
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}


#### Terraform Resource for creating AWS Lambda

resource "aws_lambda_function" "example" {
  function_name = "ExampleFunction"
  filename      = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  role          = aws_iam_role.example.arn
}


### Terraform resource for creating an IAM role

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


#### Configure the DynamoDB Stream Trigger for Lambda

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = aws_dynamodb_table.example.stream_arn
  function_name    = aws_lambda_function.example.function_name
  batch_size       = 5
}


### You'll need to retrieve the DynamoDB Stream ARN from the DynamoDB table to use it as an event source in the Lambda function. 
### Add the following code to your Terraform configuration:

data "aws_dynamodb_table" "example" {
  name = aws_dynamodb_table.example.name
}

output "dynamodb_stream_arn" {
  value = aws_dynamodb_table.example.stream_arn
}
