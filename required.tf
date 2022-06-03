variable "namespace" {
  description = "The namespace for the alarm's associated metric. See docs for the list of namespaces. See docs for supported metrics."
  validation {
    condition = contains([
      "AWS/Lambda",
      "AWS/Kinesis",
      "AWS/SQS",
      "AWS/States",
      "AWS/SES",
    ], var.namespace)
    error_message = "Namespace is not currently supported by this module."
  }
  type = string
}
