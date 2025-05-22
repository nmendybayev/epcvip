# # Uncomment the following block if you're using an S3 bucket for the Terraform remote backend
# # and DynamoDB for state locking and consistency.



# # Fetching identity:
# data "aws_caller_identity" "current" {}

# # Creating policy to access to S3 bucket and DynamoDB table:
# resource "aws_iam_policy" "terraform_backend_policy" {
#   name        = "TerraformS3DynamoDBAccess"
#   description = "Allows Terraform to access S3 and DynamoDB for remote state"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid    = "TerraformStateS3Access",
#         Effect = "Allow",
#         Action = [
#           "s3:ListBucket",
#           "s3:GetObject",
#           "s3:PutObject",
#           "s3:DeleteObject"
#         ],
#         Resource = [
#           "arn:aws:s3:::${var.backend_s3_bucket}",
#           "arn:aws:s3:::${var.backend_s3_bucket}/*"
#         ]
#       },
#       {
#         Sid    = "TerraformStateLockingDynamoDB",
#         Effect = "Allow",
#         Action = [
#           "dynamodb:GetItem",
#           "dynamodb:PutItem",
#           "dynamodb:DeleteItem",
#           "dynamodb:Scan",
#           "dynamodb:Query",
#           "dynamodb:UpdateItem"
#         ],
#         Resource = "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${var.backend_dynamodb_table}"
#       }
#     ]
#   })
# }

# # Attaching policy to the AWS user:
# resource "aws_iam_user_policy_attachment" "attach_backend_policy" {
#   user       = var.iam_user_name
#   policy_arn = aws_iam_policy.terraform_backend_policy.arn
# }