module "vpc" {
  source = "./modules/vpc"
  vpc-cidr = var.vpc-cidr
  subnet-cidrs = var.subnet-cidrs
  subnet-names = var.subnet-names
}

module "sg"{
  source = "./modules/sg"
  vpc_id = module.vpc.vpc-id
}

module "ec2"{
  source = "./modules/ec2"
}

module "alb"{
  source = "./modules/alb"
  vpc-id = module.vpc.vpc-id
  subnet-ids = module.vpc.subnet-ids
  sg-id = module.sg.sg-id
}

module "autoscaling"{
  source = "./modules/autoscaling"
  AMI-id = module.ec2.AMI-id
  sg-id = module.sg.sg-id
  availability-zones = module.vpc.availability-zones
  alb-target-group-arn = module.alb.alb-target-group-arn
  subnet-ids = module.vpc.subnet-ids
}
