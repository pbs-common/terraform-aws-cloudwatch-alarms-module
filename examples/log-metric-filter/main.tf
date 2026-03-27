resource "aws_cloudwatch_log_group" "log_group" {
  name_prefix = var.product
}

module "alarm" {
  source = "../.."

  namespace   = upper(var.product)
  metric_name = "ExampleJobFailures"

  log_metric_filter = {
    name           = "${upper(var.product)}_ExampleJobFailures"
    pattern        = "\"Job failed\""
    log_group_name = aws_cloudwatch_log_group.log_group.name
  }

  name                = "example-tf-cloudwatch-alarms-log-metric-filter"
  alarm_description   = "Alarm for example job failures detected via log metric filter"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  period              = 300
  threshold           = "1"
  treat_missing_data  = "notBreaching"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
