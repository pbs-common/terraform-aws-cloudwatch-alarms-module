variable "state_machine_arn" {
  description = "ARN of the state machine being monitored"
  default     = null
  type        = string
}

variable "lambda_function" {
  description = "Name of the Lambda function being monitored"
  default     = null
  type        = string
}

variable "kinesis_stream" {
  description = "Name of the Kinesis stream being monitored"
  default     = null
  type        = string
}

variable "queue_name" {
  description = "Name of the SQS queue being monitored"
  default     = null
  type        = string
}

variable "mediatailor_configuration_name" {
  description = "Name of the MediaTailor configuration being monitored"
  default     = null
  type        = string
}
