terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

# Create the S3 bucket
resource "aws_s3_bucket" "ulli5" {
  bucket        = "me-ulli5"
  force_destroy = true

  tags = {
    Environment = "development"
  }

  versioning {
    enabled = true
  }
}

# Website hosting configuration
resource "aws_s3_bucket_website_configuration" "tirupataiah" {
  bucket = aws_s3_bucket.ulli5.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# (Optional) Object lock
resource "aws_s3_bucket_object_lock_configuration" "object_lock" {
  bucket = aws_s3_bucket.ulli5.id

  object_lock_enabled = "Enabled"

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 30
    }
  }
}

# Remove public access blocking
resource "aws_s3_bucket_public_access_block" "no_block" {
  bucket = aws_s3_bucket.ulli5.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Public read policy
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.ulli5.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.ulli5.arn}/*"
    }]
  })
}

# Upload index.html and error.html to the root of the bucket
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.ulli5.id
  key          = "index.html"
  source       = "${path.module}/tirup-react-basic/public/index.html"
  content_type = "text/html"
  acl          = "public-read"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.ulli5.id
  key          = "error.html"
  source       = "${path.module}/tirup-react-basic/public/error.html"
  content_type = "text/html"
  acl          = "public-read"
}

# Output website endpoint
output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.tirupataiah.website_endpoint
}

output "bucket_name" {
  value = aws_s3_bucket.ulli5.bucket
}
