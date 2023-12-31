resource "aws_ami_from_instance" "AutoScaling-AMI" {
  name = "Autoscaling-AMI"
  source_instance_id = "i-01ba3656b7a084213"
}
