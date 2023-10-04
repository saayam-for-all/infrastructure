# Create an S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "saayamorg-iac-state001"  # Replace with your desired bucket name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}

# IAM Role for Terraform
resource "aws_iam_role" "terraform_role" {
  name = "terraform-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for Terraform to access the S3 bucket
resource "aws_iam_policy" "terraform_policy" {
  name        = "terraform-policy"
  description = "IAM policy for Terraform to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
        ],
        Effect   = "Allow",
        Resource = [
          aws_s3_bucket.terraform_state.arn,
          "${aws_s3_bucket.terraform_state.arn}/*",
        ],
      },
    ],
  })
}

# Attach the IAM policy to the Terraform IAM role
resource "aws_iam_role_policy_attachment" "terraform_policy_attachment" {
  policy_arn = aws_iam_policy.terraform_policy.arn
  role       = aws_iam_role.terraform_role.name
}