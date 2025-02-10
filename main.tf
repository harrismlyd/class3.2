provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "harris-s3-tf-ci.tfstate" #Change this
    region = "ap-southeast-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", "data.aws_caller_identity.current.arn")[0]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"

  # checkov:skip=CKV2_AWS_62
  # checkov:skip=CKV_AWS_21
  # checkov:skip=CKV2_AWS_6
  # checkov:skip=CKV_AWS_18
  # checkov:skip=CKV_AWS_144
  # checkov:skip=CKV_AWS_145
  # checkov:skip=CKV2_AWS_61
}
