module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucketname
  acl    = "public-read"

  

  versioning = {
    enabled = false
  }

  website = {index_document = "index.html"}
  # attach_public_policy = true
  policy = templatefile("policy.json", {bucketname = var.bucketname})
}


resource "aws_s3_object" "object-index" {
  bucket = module.s3_bucket.s3_bucket_id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_logging" "example" {
  bucket = module.s3_bucket.s3_bucket_id

  target_bucket = "intern-server-access-logs"
  target_prefix = "${var.bucketname}/"
}

