#terraform store
terraform {
  backend "s3" {
    bucket = "prd-tf-s3-buket"
    key = "aws-prod-ecs.tfstate"
    region = "us-east-1"
    profile = "admin"
  }
}

#vpc craetion
module "vpc" {
  source                        = "../modules/vpc"
  region                        = var.region
  aws-project                   = var.aws-project
  vpc_cidr                      = var.vpc_cidr
  aws-prd-public-subnet-1-cidr  = var.aws-prd-public-subnet-1-cidr
  aws-prd-pvt-data-sbnt-1       = var.aws-prd-pvt-subnet-1-cidr
  aws-prd-pvt-subnet-1-cidr     = var.aws-prd-pvt-data-sbnt-1
  public-subnet-az1-cidr        = var.public-subnet-az1-cidr
}