resource "aws_lb_target_group" "LoadBalancing-targetGroup" {
  target_type = "instance"
  protocol = "HTTP"
  port = 80
  vpc_id = var.vpc-id
  
  tags = {
    Name = "LoadBalancing-Targetgroup"
  }
}

resource "aws_lb" "ALB" {
  load_balancer_type = "application"
  internal = false
  ip_address_type = "ipv4"
  security_groups = [var.sg-id]
  subnets = var.subnet-ids

  tags = {
    Name = "Project-Load-Balancer"
  }
}

resource "aws_lb_listener" "Listener-Process" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "443"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.LoadBalancing-targetGroup.arn
  }
}
