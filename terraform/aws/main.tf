terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider configuration
# Credentials are picked up automatically from CircleCI environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
provider "aws" {
  region = var.aws_region
}

# Resource: S3 Bucket
resource "aws_s3_bucket" "static_site" {
  bucket = var.aws_bucket_name
  tags = {
    Name        = "StaticSiteBucket"
    Environment = "Dev"
  }
}

# Resource: S3 Bucket ACL
resource "aws_s3_bucket_acl" "static_site_acl" {
  bucket = aws_s3_bucket.static_site.id
  acl    = "public-read"
}

# Resource: Static Website configuration
resource "aws_s3_bucket_website_configuration" "static_site_config" {
  bucket = aws_s3_bucket.static_site.id
  index_document {
    suffix = "index.html"
  }
}

# Output the website endpoint
output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.static_site_config.website_endpoint
}
