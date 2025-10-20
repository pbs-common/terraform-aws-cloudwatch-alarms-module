resource "aws_iam_role" "role" {
  name_prefix = "example-cw-alarm-sfn-"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_sfn_state_machine" "state_machine" {
  name     = "${var.product}-sfn"
  role_arn = aws_iam_role.role.arn

  definition = <<EOF
{
  "Comment": "A state machine that immediately fails to show that the alarm works",
  "StartAt": "FailNow",
  "States": {
    "FailNow": {
      "Type": "Fail",
      "Cause": "Necessary evil."
    }
  }
}
EOF
}

module "alarm" {
  source = "../.."

  namespace         = "AWS/States"
  state_machine_arn = aws_sfn_state_machine.state_machine.arn

  organization = var.organization
  environment  = var.environment
  product      = var.product
  owner        = var.owner
  repo         = var.repo
}
