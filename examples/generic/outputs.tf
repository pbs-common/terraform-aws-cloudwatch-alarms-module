output "arn" {
  description = "ARN of the alarm provisioned"
  value       = module.alarm.arn
}

output "name" {
  description = "Name of the alarm provisioned"
  value       = module.alarm.name
}
