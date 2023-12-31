terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.31.0"
    }
  }

  backend "s3" {
    bucket = "terraform-autoscaling-bucket"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider aws {
  region = "us-east-1"
  shared_credentials_files = ["/Users/thamb/.aws/credentials"]
  profile = "disciklean"
}