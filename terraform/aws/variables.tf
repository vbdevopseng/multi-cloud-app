variable "aws_region" {
  description = "The AWS region to deploy to."
  type        = string
  default     = "us-east-1" # Change this to your preferred region
}

variable "aws_bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string
}
