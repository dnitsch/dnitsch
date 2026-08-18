# amazon certificate manager and route53
# ---------------------------------------------
# look up the DNS zone
data "aws_route53_zone" "default" {
  name         = var.dns_zone
  private_zone = false
  provider     = aws.dns
}
# create the certificate with lifecycle policy (creates new before destroying old when replacing a certificate)
resource "aws_acm_certificate" "default" {
  domain_name       = local.domain_name
  validation_method = "DNS"
  provider          = aws.use1
  tags              = module.default_label.tags

  lifecycle {
    create_before_destroy = true
  }
}
# create the record(s) for certificate validation
resource "aws_route53_record" "default" {
  for_each = {
    for dvo in aws_acm_certificate.default.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.default.zone_id
  provider        = aws.dns
}

# perform the validation
resource "aws_acm_certificate_validation" "default" {
  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = [for record in aws_route53_record.default : record.fqdn]
  provider                = aws.use1
}

# Cloufront distribution
# ---------------------------------------------
# create the distribution, configure settings, point the distro to the S3 origin, select the certificate
# and point custom domain name to the cloudfront distro
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = module.dashboard_bucket.s3_bucket_bucket_regional_domain_name
    origin_id   = module.dashboard_bucket.s3_bucket_id
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Web Dashboard ${module.default_label.id}"
  default_root_object = "index.html"
  provider            = aws.use1
  aliases             = [local.domain_name]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = module.dashboard_bucket.s3_bucket_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 8640
  }

  custom_error_response {
    error_code            = "403"
    response_code         = "200"
    error_caching_min_ttl = 300
    response_page_path    = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.default.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  # logging_config {
  #   include_cookies = false
  #   bucket = module.log_bucket.s3_bucket_arn
  #   prefix = "${module.default_label.id}-cf-log/"
  # }
}

resource "aws_route53_record" "dashboard" {
  zone_id  = data.aws_route53_zone.dashboard.zone_id
  name     = local.domain_name
  type     = "A"
  provider = aws.dns
  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
