resource "aws_sns_topic" "for_module" {
  name = "module_sns_topic"
}

output "aws_sns_topic_arn" {
  value = aws_sns_topic.for_module.arn
}
