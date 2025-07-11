resource "aws_s3_bucket" "module_s3" {
  bucket = "module_s3"

  tags = {
    Name        = "Module S3 Bucket"
    Environment = "dev"
  }
  
}