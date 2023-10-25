### Creating custom backup solutions in AWS using Terraform can be highly specific to 
### your use case and can involve various AWS services, IAM roles, and Lambda functions. 
### Below is a simplified example that demonstrates how you can use Terraform to set up a custom backup solution for Amazon EC2 instances using AWS Lambda functions. 
### In this example, we'll create Lambda functions to create snapshots of EC2 instances on a defined schedule.

provider "aws" {
  region = "us-east-1"  # Set your desired region
}

# IAM Role for Lambda Function
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ec2:CreateSnapshot",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:CreateTags",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

# Lambda Function to Create EC2 Snapshots
resource "aws_lambda_function" "ec2_snapshot_lambda" {
  function_name = "ec2-snapshot-lambda"
  handler      = "index.handler"
  runtime      = "nodejs14.x"
  filename     = "lambda/lambda.zip"  # Replace with the path to your Lambda deployment package

  role = aws_iam_role.lambda_execution_role.arn

  source_code_hash = filebase64sha256("lambda/lambda.zip")
}

# CloudWatch Event Rule to Trigger Lambda Function on a Schedule
resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "ec2-snapshot-schedule"
  description         = "Schedule to trigger EC2 snapshot Lambda function"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.schedule.name
  arn  = aws_lambda_function.ec2_snapshot_lambda.arn
}

# Provide necessary environment variables to the Lambda function
resource "aws_lambda_function_environment" "lambda_env" {
  function_name = aws_lambda_function.ec2_snapshot_lambda.function_name
  variables = {
    AWS_REGION   = "us-east-1",  # Set the region where your EC2 instances are located
    TAG_KEY      = "Backup",
    TAG_VALUE    = "true",
  }
}
