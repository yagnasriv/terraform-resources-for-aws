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

  # Optional tags
#   tags = {
#     Environment = "Production",
#     Department  = "Engineering",
#   }
 }
