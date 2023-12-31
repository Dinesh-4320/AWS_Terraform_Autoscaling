resource "aws_security_group" "AS-SG" {
    description = "This SG allows HTTPS and SSH access to Autoscaling instances"
    vpc_id = var.vpc_id
    
    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port  = 0
        protocol  = "-1"
        cidr_blocks  = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "Autoscaling Security Group"
    }
}