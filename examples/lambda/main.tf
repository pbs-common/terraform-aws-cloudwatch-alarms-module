resource "aws_iam_role" "role" {
  name_prefix = "example-cw-alarm-lambda-"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda" {
  filename      = "fake-zip.zip"
  function_name = var.product
  role          = aws_iam_role.role.arn
  handler       = "exports.test"

  source_code_hash = filebase64sha256("fake-zip.zip")

  runtime = "nodejs20.x"
}

module "alarm" {
  source = "../.."

  namespace       = "AWS/Lambda"
  lambda_function = aws_lambda_function.lambda.id

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
