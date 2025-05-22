# # Creating S3 bucket for Terraform state:
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = var.s3_bucket_name

#   tags = {
#     Name        = "Terraform Remote State Bucket"
#     Environment = "Terraform Backend"
#   }
# }

# # Enabling versioning on the bucket:
# resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Enabling server-side encryption:
# resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # Adding cost-efective feature to delete old files:
# resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     id     = "cleanup-old-versions"
#     status = "Enabled"

#     filter {
#       prefix = "" # Applies to all objects
#     }

#     noncurrent_version_expiration {
#       noncurrent_days = 90
#     }
#   }
# }

# # Blocking all public access to the bucket:
# resource "aws_s3_bucket_public_access_block" "block_public_access" {
#   bucket = aws_s3_bucket.terraform_state.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # Creating DynamoDB table for Terraform state locking:
# resource "aws_dynamodb_table" "terraform_lock" {
#   name         = var.dynamodb_table_name
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "Terraform Lock Table"
#     Environment = "Terraform Backend"
#   }
# }