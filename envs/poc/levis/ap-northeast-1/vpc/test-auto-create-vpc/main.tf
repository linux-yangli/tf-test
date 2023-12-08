provider "aws" {
  region = "ap-northeast-1"

}

module "vpc" {
  source = "../../../../../../modules/vpc_eks"
  vpc_name = "test-auto-create-vpc"
  vpc_cidr = "10.10.0.0/16"
}