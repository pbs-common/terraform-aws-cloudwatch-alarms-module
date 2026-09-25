# PBS TF CloudWatch Alarms Module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-cloudwatch-alarms-module?ref=x.y.z
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

This module provisions a CloudWatch alarm.

It is an opinionated module that will configure CloudWatch alarms with as little manual configuration as possible. See the examples located in the [examples folder](/examples) to see what kind of resources are supported.

Integrate this module like so:

```hcl
module "alarm" {
  source = "github.com/pbs/terraform-aws-cloudwatch-alarms-module?ref=x.y.z"

  namespace       = "AWS/Lambda"
  lambda_function = aws_lambda_function.lambda.id

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo

  # Optional Parameters
}
```

### Unsupported Resource Types

Resource types that this module does not model explicitly can still be alarmed on by supplying `dimensions` directly:

```hcl
module "alarm" {
  source = "github.com/pbs/terraform-aws-cloudwatch-alarms-module?ref=x.y.z"

  namespace   = "AWS/DynamoDB"
  metric_name = "ThrottledRequests"

  dimensions = {
    TableName = aws_dynamodb_table.table.name
    Operation = "PutItem"
  }

  alarm_actions = [aws_sns_topic.alarms.arn]
  ok_actions    = [aws_sns_topic.alarms.arn]

  # Tagging Parameters
  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}
```

`dimensions` is merged with the dimensions derived from the resource specific variables (e.g. `lambda_function`, `kinesis_stream`) and takes precedence on key collisions.

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs
