variable "vpc-cidr" {
  description = "CIDR for Autoscaling infrastructure VPC"
  type = string
  default = "10.0.0.0/24"
}

variable "subnet-cidrs" {
  description = "CIDR for subnets"
  type = list(string)
  default = ["10.0.0.16/28","10.0.0.32/28"]
}

variable "subnet-names" {
  description = "Names for subnets"
  type = list(string)
  default = [ "Autoscaling-subnet-1","Autoscaling-subnet-2" ]
}