##### this code deploy static website in s3 
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.12.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "random_id" "randm_id" {
    byte_length = 4
  
}
resource "aws_s3_bucket" "demo-xx-bucket" {
    bucket = "demo-${random_id.randm_id.hex}"
  
}

resource "aws_s3_object" "bucket-date" {
    bucket = aws_s3_bucket.demo-xx-bucket.bucket
    source = "./myfile.txt"
    etag         = filemd5("./myfile.txt")
    key = "index.html"
    content_type = "html" 
  }

# Disable "Block Public Access" (required for public website hosting)
resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket = aws_s3_bucket.demo-xx-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.demo-xx-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.demo-xx-bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.allow_public]
}

resource "aws_s3_bucket_website_configuration" "demowebapp" {
  bucket = aws_s3_bucket.demo-xx-bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "name" {
    value = aws_s3_bucket_website_configuration.demowebapp.website_endpoint
  
}