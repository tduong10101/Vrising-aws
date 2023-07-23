terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
        }
    }

    backend "s3" {
        bucket = var.backend_bucket
        key    = var.backend_key
        region = var.backend_region
    }
}

# Configure the AWS Provider
provider "aws" {
    region = "ap-south-east-2"
}


