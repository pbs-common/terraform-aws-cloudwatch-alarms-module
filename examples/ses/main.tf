module "alarm" {
  source = "../.."

  namespace = "AWS/SES"

  threshold         = "750"
  period            = "3600"
  statistic         = "Sum"
  metric_name       = "Send"
  alarm_description = "SES alarm for SEND action (>750)"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
