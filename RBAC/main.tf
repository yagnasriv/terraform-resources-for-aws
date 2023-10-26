### RBAC (Role-Based Access Control) 
### in AWS is a method of controlling access to AWS resources and services by defining roles and permissions for users, groups, and applications

### In AWS, RBAC is primarily implemented through the use of IAM (Identity and Access Management) roles and policies

# Creating an IAM User on AWS 

provider "aws" {
  region = "us-east-1"  # Set your desired region
}

resource "aws_iam_user" "example_user" {
  name = "praneeth"
  path = "/users/"

 }

resource "aws_iam_group" "example_group" {
  name = "DevOps"
  # Optional path for organizing your IAM groups
  path = "/groups/"
  }



resource "aws_iam_role" "example_role" {
  name = "my-role"
  # Optional path for organizing your IAM roles
  path = "/roles/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"  # Example: Allow EC2 instances to assume this role
        }
      }
    ]
  })

}



resource "aws_iam_policy" "example_policy" {
  name        = "MyExamplePolicy"
  description = "An example IAM policy"

  # Specify the policy document using JSON
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "s3:GetObject",
          "s3:ListBucket",
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::my-example-bucket/*",
          "arn:aws:s3:::my-example-bucket",
        ],
      },
      {
        Action   = "ec2:Describe*",
        Effect   = "Allow",
        Resource = "*",
      },
    ]
  })
}


# Create an IAM policy that will serve as the permission boundary
resource "aws_iam_policy" "permission_boundary" {
  name        = "MyPermissionBoundary"
  description = "An example permission boundary policy"

  # Specify the permission boundary policy document using JSON
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "*",
        Effect   = "Allow",
        Resource = "*",
      },
    ]
  })
}

# Attach the permission boundary policy to the IAM user
resource "aws_iam_user_policy_attachment" "user_permission_boundary" {
  policy_arn = aws_iam_policy.permission_boundary.arn
  user       = aws_iam_user.example_user.name
}


