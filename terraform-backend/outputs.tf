# output "s3_bucket_name" {
#   description = "S3 bucket name used for Terraform state"
#   value       = aws_s3_bucket.terraform_state.bucket
# }

# output "dynamodb_table_name" {
#   description = "DynamoDB table name used for state locking"
#   value       = aws_dynamodb_table.terraform_lock.name
# }