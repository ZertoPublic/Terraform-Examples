terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "1.24.2"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


module "zvm-in-vsphere" {
  source = "./modules/zvm_in_vsphere"
}

module "zca-in-aws" {
  source = "./modules/zca_in_aws"
}

module "sample-vms-in-vsphere" {
  source = "./modules/sample_vms_in_vsphere"
}
