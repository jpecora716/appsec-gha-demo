terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  region = "us-west-2"
}

locals {
  companylist = compact(split("\n", file("./companies")))
}

resource "aws_s3_bucket" "example" {
  for_each = local.companylist
  bucket = "company-${each.value}"
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id
  block_public_acls   = false
  block_public_policy = false
}
