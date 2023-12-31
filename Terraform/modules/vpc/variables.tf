variable "vpc-cidr" {
  description = "CIDR for Autoscaling infrastructure"
  type = string
}

variable "subnet-cidrs" {
  description = "CIDR for subnets"
  type = list(string)
}

variable "subnet-names" {
  description = "Names for subnets"
  type = list(string)
}