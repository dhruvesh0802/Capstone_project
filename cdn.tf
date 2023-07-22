# Add product cloudfront distribution
resource "aws_cloudfront_distribution" "product_s3_distribution" {
  origin {
    domain_name = module.s3_bucket.s3_bucket_bucket_domain_name
    origin_id   = module.s3_bucket.s3_bucket_id
    
    
  }

  default_root_object = "index.html"

  enabled             = true   # enable CloudFront distribution
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for staging"

#   aliases = ["${var.route53_record_name}.${var.domain_name}"]
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = module.s3_bucket.s3_bucket_id
    
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    # origin_ssl_protocols   = ["TLSv1.2_2021"]
    min_ttl                = 0        # min time for objects to live in the distribution cache
    default_ttl            = 3600     # default time for objects to live in the distribution cache
    max_ttl                = 86400    # max time for objects to live in the distribution cache
  }

  restrictions {
    geo_restriction {
        restriction_type = "none"
    }
  }

  viewer_certificate {
    # cloudfront_default_certificate = true   # use this if you don't have certificate
    acm_certificate_arn = "arn:aws:acm:us-east-1:587172484624:certificate/4a382046-f0f6-4203-bfe5-a6319c62c318"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = ["row22.dns-poc-onprem.tk"]


#   depends_on = [aws_acm_certificate.cloudfront_cdn]
}

# resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
#     comment = local.s3_origin_id
# }

# locals {
#   s3_origin_id = "row22-s3-origin"
# }