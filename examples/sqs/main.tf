resource "aws_sqs_queue" "queue" {
  name_prefix       = var.product
  kms_master_key_id = "alias/aws/sqs"
}

module "alarm" {
  source = "../.."

  namespace  = "AWS/SQS"
  queue_name = aws_sqs_queue.queue.name

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
