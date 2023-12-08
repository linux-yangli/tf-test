provider "aws" {
  region = "ap-northeast-1"

}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-state-aws-751016523017-ap-northeast-1-poc"
    key            = "new/envs/poc/levis/ap-northeast-1/vpc/test-auto-create-vpc/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-locks"
  }
}

module "vpc" {
  source = "../../../../../../modules/vpc_eks"
  vpc_name = "test-auto-create-vpc"
  vpc_cidr = "10.10.0.0/16"
}