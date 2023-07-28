terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
        }
    }

    backend "s3" {
        bucket = "tduong10101-terraform-state-bucket"
        key    = "terraform_state"
        region = "ap-southeast-2"
    }
}

# Configure the AWS Provider
provider "aws" {
    region = "ap-southeast-2"
    assume_role {
        role_arn = var.tf_role_arn
    }
}


