terraform {
  backend "s3" {
    bucket         = "saayamorg-iac-state001"
    key            = "eks.tfstate"
    region         = "us-east-1"  # Replace with your desired region
    access_key     = ""
    secret_key     = ""
    encrypt        = true
    #dynamodb_table = "terraform-lock"  # Optional: Add a DynamoDB table for state locking
    
  }
}