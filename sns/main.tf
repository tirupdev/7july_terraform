terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0"
}
provider "aws" {
  region = "ap-south-2"
}

resource "aws_sns_topic" "july2025" {
  name         = "sns-july2025"
  display_name = "SNS Topic July 2025"
  tags = {
    Environment = "Production"
    Project     = "SNS Example"
    CreatedBy   = "Terraform"
  }
}

resource "aws_sns_topic" "july72025" {
  name         = "sns-7july2025"
  display_name = "SNS Topic 7 July 2025"
  tags = {
    Environment = "development"
    Project     = "SNS Example"
    CreatedBy   = "Terraform"
  }
  
}

resource "aws_sns_topic" "july82025" {
    name = "sns-july2025"

    lifecycle {
      prevent_destroy = true
    }
  
}








resource "aws_sns_topic_subscription" "email"{
  topic_arn = aws_sns_topic.july2025.arn
  protocol = "email"
  endpoint = "ulli.tirupataiah@gmail.com"
  confirmation_timeout_in_minutes = 5
}
resource "aws_sns_topic_subscription" "mobile"{
    topic_arn = aws_sns_topic.july2025.arn
    protocol = "sms"
    endpoint = "+91-8885653080"
    confirmation_timeout_in_minutes = 5

}


resource "aws_sns_topic_subscription" "mobile2" {
    topic_arn = aws_sns_topic.july2025.arn
    protocol = "sms"
    endpoint = "+91-8500990760"
    confirmation_timeout_in_minutes = 5
  
}
output "email_subscription_arn" {
  value = aws_sns_topic_subscription.email.arn
  
}

output "mobile_subscription_arn" {
  value = aws_sns_topic_subscription.mobile.arn
}

