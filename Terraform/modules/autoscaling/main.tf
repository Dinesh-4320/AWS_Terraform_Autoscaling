resource "aws_launch_template" "autoScalingLaunchTemplate" {
  image_id = var.AMI-id
  instance_type = "t2.micro"
  key_name = "Meme"
  vpc_security_group_ids = [var.sg-id]

  monitoring {
    enabled = true
  }

  tags = {
    Name = "Autoscaling-Launch-Template"
  }
}

resource "aws_autoscaling_group" "autoscalingGroup" {
    name = "Autoscaling-Group"
    vpc_zone_identifier = [ var.subnet-ids[0],var.subnet-ids[1] ]
    metrics_granularity = "1Minute"
    desired_capacity = 2
    min_size = 2
    max_size = 6
  

    launch_template {
      id = aws_launch_template.autoScalingLaunchTemplate.id
      version = "$Latest"
    }
}

resource "aws_autoscaling_attachment" "autoScalingAttachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscalingGroup.id
  lb_target_group_arn = var.alb-target-group-arn
} 

resource "aws_autoscaling_policy" "autoScalingPolicy" {
  name = "Project-Autoscaling-Policy"
  autoscaling_group_name = aws_autoscaling_group.autoscalingGroup.id
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

resource "aws_autoscaling_notification" "autoScalingNotification" {
  group_names = [aws_autoscaling_group.autoscalingGroup.id]
  topic_arn = aws_sns_topic.notificationTopic.arn
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    ]
}

resource "aws_sns_topic" "notificationTopic" {
  name = "AutoScaling-Notification"
}

resource "aws_autoscaling_group_tag" "autoscalingTag" {
  autoscaling_group_name = aws_autoscaling_group.autoscalingGroup.id

  tag {
    key = "Name"
    value = "Project-instance"
    propagate_at_launch = true
  }
}