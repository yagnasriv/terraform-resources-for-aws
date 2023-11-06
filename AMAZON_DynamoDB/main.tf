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

resource "aws_dynamodb_table" "tf_notes_table" { 
   name = "tf-notes-table-03" 
   billing_mode = "PROVISIONED" 
   read_capacity = "30" 
   write_capacity = "30" 
   attribute { 
      name = "noteId" 
      type = "S" 
   } 
   hash_key = "noteId" 
   ttl { 
     enabled = true
     attribute_name = "expiryPeriod"  
   }
   point_in_time_recovery { enabled = true } 
   server_side_encryption { enabled = true } 
   lifecycle { ignore_changes = [ "write_capacity", "read_capacity" ] }
} 

module  "table_autoscaling" { 
   source = "snowplow-devops/dynamodb-autoscaling/aws" 
   table_name = aws_dynamodb_table.tf_notes_table.name
}


# resource "aws_dynamodb_table" "tf_notes_table" {
#  name = "tf-notes-table-yv02"
#  billing_mode = "PROVISIONED"
#  read_capacity= "30"
#  write_capacity= "30"
#  attribute {
#   name = "noteId"
#   type = "S"
#  }
#  hash_key = "noteId"
#  point_in_time_recovery {
#    enabled = true
#  }

# }
