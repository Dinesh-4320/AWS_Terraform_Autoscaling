variable "AMI-id" {
  description = "Id of the Autoscaling AMI"
  type = string
}

variable "sg-id" {
  description = "Id of the Autoscaling Security Group"
  type = string
}

variable "availability-zones" {
  description = "Availability zones of Autoscaling VPC"
  type = list(string)
}

variable "alb-target-group-arn" {
  description = "ARN of the existing load balancer"
  type = string
}

variable "subnet-ids" {
  description = "Subnets IDs for the autoscaling VPC"
  type = list(string)
}
