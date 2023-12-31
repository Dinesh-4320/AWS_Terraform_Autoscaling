variable "vpc-id" {
  description = "Autoscaling VPC ID"
  type = string
}

variable "sg-id" {
  description = "Autoscaling VPC Security group"
  type = string
}

variable "subnet-ids" {
  description = "Subnet ids of subnets in VPC"
  type = list(string)
}