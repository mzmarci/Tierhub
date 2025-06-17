terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket = "workspacebucket-2023"
    key    = "Dev/terraform.tfstate"
    region = "eu-west-1"
    //dynamodb_table = "terraform-locks"
  }

}

provider "aws" {
  region = "eu-west-1"
}


# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "terraform-locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "Terraform State Lock Table"
#     Environment = "Dev"
#   }
# }

# // N.B - whenever u want to run this appliaction, first Temporarily comment out the backend block and run terraform init, This creates the DynamoDB table.Uncomment the backend block and run terraform init again so that Terraform will reinitialize the backend using your new DynamoDB table for state locking.

 