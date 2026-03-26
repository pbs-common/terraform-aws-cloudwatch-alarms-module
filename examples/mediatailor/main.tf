module "alarm" {
  source = "../.."

  namespace                      = "AWS/MediaTailor"
  mediatailor_configuration_name = var.product

  name                = var.product
  alarm_description   = "Alarm for MediaTailor AdDecisionServer.Timeouts"
  metric_name         = "AdDecisionServer.Timeouts"
  period              = 1800
  comparison_operator = "GreaterThanThreshold"
  threshold           = "0"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
