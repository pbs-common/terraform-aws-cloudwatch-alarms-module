resource "aws_sns_topic" "topic" {
  name_prefix = var.product
}

module "alarm" {
  source = "../.."

  namespace   = "AWS/SNS"
  metric_name = "NumberOfNotificationsFailed"

  # Resource types the module does not model explicitly are supported via dimensions
  dimensions = {
    TopicName = aws_sns_topic.topic.name
  }

  name                = var.product
  alarm_description   = "Alarm for failed SNS notifications"
  comparison_operator = "GreaterThanThreshold"
  period              = 300
  threshold           = "0"

  alarm_actions = [aws_sns_topic.topic.arn]
  ok_actions    = [aws_sns_topic.topic.arn]

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
