
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

module "provider" {
  source = "./provider"
}

module "lambda" {
  source ="./lambda"
}

module "s3" {
  source ="./s3"
}

module "sns" {
  source ="./sns"
}