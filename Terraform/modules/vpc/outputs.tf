output "vpc-id" {
  value = aws_vpc.autoscaling-vpc.id
}

output "subnet-ids" {
  value = aws_subnet.AS-subnet.*.id
}

output "availability-zones"{
  value = aws_subnet.AS-subnet.*.availability_zone_id
}