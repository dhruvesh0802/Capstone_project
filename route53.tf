# data "aws_route53_zone" "hosted_zone" {
#     name = var.domain_name
# }

# resource "aws_route53_record" "site-domain" {
#   zone_id = data.aws_route53_zone.hosted_zone.zone_id
#   name = var.record_name
#   type = "CNAME"


#     alias {
#         name                   = resource.aws_cloudfront_distribution
#         zone_id                = module.s3_bucket.s3_bucket_hosted_zone_id
#         evaluate_target_health = true
#     }
# }

resource "aws_route53_record" "route53_record" {
    zone_id = "Z09694789KLKEHOHJN0T"
    name = "row22"
    type = "CNAME"
    ttl = 60
    records = ["${aws_cloudfront_distribution.product_s3_distribution.domain_name}"]
}


