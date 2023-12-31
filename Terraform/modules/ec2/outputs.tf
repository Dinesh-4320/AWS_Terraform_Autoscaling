output "AMI-id" {
  value = aws_ami_from_instance.AutoScaling-AMI.id
}