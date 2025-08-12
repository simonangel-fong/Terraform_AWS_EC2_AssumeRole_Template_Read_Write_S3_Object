terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = ""
    region = ""
    key    = ""
  }
}

provider "aws" {
  region = var.aws_region
}
