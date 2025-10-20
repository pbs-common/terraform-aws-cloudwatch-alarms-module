resource "aws_kinesis_stream" "stream" {
  name        = var.product
  shard_count = 1

  encryption_type = "KMS"
  kms_key_id      = "alias/aws/kinesis"
}

module "alarm" {
  source = "../.."

  namespace      = "AWS/Kinesis"
  kinesis_stream = aws_kinesis_stream.stream.id

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
