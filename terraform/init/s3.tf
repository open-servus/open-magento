provider "aws" {
  region = local.region
}

resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = local.tf_state_bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
