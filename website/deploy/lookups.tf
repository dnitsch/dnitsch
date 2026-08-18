data "aws_caller_identity" "current" {}

data "aws_canonical_user_id" "current" {}

data "aws_cloudfront_log_delivery_canonical_user_id" "cloudfront" {}

# look up the DNS zone
data "aws_route53_zone" "dashboard" {
  name         = var.dns_zone
  private_zone = false
  provider     = aws.dns
}

# identity pool ID
# data "aws_cognito_identity_pool" "default" {
#   name = "IdentityPool${var.stage}"
# }

# user pool ID
data "aws_cognito_user_pools" "default" {
  name = "anabode-${var.stage}-cognito-pool"
}

