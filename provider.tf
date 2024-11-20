terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4"
        }
    }
}


provider "aws" {
  profile = var.profile_name
  region = var.this_region
}