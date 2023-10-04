terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.49.0, < 5.0.0"
    }
  }
}
provider "aws" {
  region     = "us-east-1"  # Replace with your desired region
  access_key = "AKIAXIE45C6N246L7X73"
  secret_key = "B3fW4aKHLOgiPuMeUlGXeL7pJUUavLZ9W9mdWN75"
  # Optional: session_token = "YOUR_SESSION_TOKEN" # Include if you're using temporary session tokens
}