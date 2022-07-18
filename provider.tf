terraform {
  backend "s3" {
    bucket = "eshop-sean"        # my-s3-bucket
    key    = "eshop/terraform.tfstate"
    region = "ap-northeast-2"      # us-east-1, us-west-2 
  }
  required_version = ">=1.1.3"
}

provider "aws" {
  region = var.aws_region
}
