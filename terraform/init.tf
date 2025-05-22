# Terraform configuration using local state
# To use an S3 remote backend with DynamoDB state locking, uncomment the `backend "s3"` block below (check user permissions first)

terraform {
  required_version = ">= 1.2.0"

  # Uncomment to enable remote state storage in S3 with DynamoDB locking
  # backend "s3" {
  #   bucket         = "terraform-state-bucket-neptune"
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-lock-table-neptune"
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}