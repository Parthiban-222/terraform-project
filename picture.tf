provider "aws" {
  region     = "us-east-1"
  access_key = "acess-key"
  secret_key = "secret-key"
}

resource "aws_s3_bucket" "parthi1" {
  bucket = "circ-buk"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.parthi1.bucket
  key    = "parthi.html"
  source = "./parthi.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "public_acces_enable" {
  bucket = aws_s3_bucket.parthi1.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "owner_bucket_change" {
  bucket = aws_s3_bucket.parthi1.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.parthi1.bucket
  policy = jsonencode({
    "Version":"2012-10-17",
    "Statement":[
        {
           "Sid":"Statement1",
            "Effect":"Allow",
            "Principal":"*",
            "Action":"s3:GetObject",
            "Resource":"arn:aws:s3:::circ-buk/*"
        }
    ]
}
)
}


