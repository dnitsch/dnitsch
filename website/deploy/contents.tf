resource "aws_s3_object" "default" {
  # Add all files in build to be uploaded
  # Skip .subst always
  # and conditionally upload .map in dev for easy debug in browser
  for_each               = { for k in fileset(var.build_output_path, "**") : k => { name : k } if !endswith(k, ".subst") }
  bucket                 = module.dashboard_bucket.s3_bucket_id
  key                    = replace(each.value.name, "${var.build_output_path}/", "")
  content_type           = lookup(local.content_types, reverse(split(".", trimsuffix(each.value.name, ".map")))[0], "text/plain")
  source                 = "${var.build_output_path}/${each.value.name}"
  source_hash            = filemd5("${var.build_output_path}/${each.value.name}")
  cache_control          = each.value.name == "index.html" ? "no-cache, no-store, must-revalidate" : null
  acl                    = "public-read"
  server_side_encryption = "AES256"
  # lifecycle {
  #   replace_triggered_by = [aws_s3_object.default[each.key].source_hash]
  # }
}

locals {
  config_content = templatefile("${var.build_output_path}/config.js.subst", {
    LOG_LEVEL : var.log_level,
    BUILD_VERSION : var.commit_sha,
    AWS_REGION : var.region,
    // format => cognito-idp.eu-west-1.amazonaws.com/eu-west-1_mELATScZv
    # NOTE: this is built in the app via AWS_REGION and IDP_ID
    IDP_ID : tolist(data.aws_cognito_user_pools.default.ids)[0],
    // format => eu-west-1:84d2b322-9880-4a28-87f4-ff2df24a8fe7
    # THIS HAS TO BE PASSED IN as there is no lookup for identity_pool_id
    IDP_POOL_ID : var.idp_pool_id,
    USER_DATA_STORAGE_BUCKET : var.user_data_storage_bucket,
    STRIPE_PUBLISHABLE_KEY : var.stripe_publishable_key,
    FIREBASE_CONFIG : var.firebase_config,
    UTILS_URL : "https://utils.${var.stage}.anabode.net",
    CHAT_URL : "https://chat.${var.stage}.anabode.net",
    ACCOUNT_URL : "https://account.${var.stage}.anabode.net",
    GENERICS_URL : "https://generics.${var.stage}.anabode.net",
    LANDLORD_URL : "https://landlord.${var.stage}.anabode.net",
    PROPERTY_URL : "https://property.${var.stage}.anabode.net",
    TENANCY_URL : "https://tenancy.${var.stage}.anabode.net",
    REPAIR_URL : "https://repair.${var.stage}.anabode.net",
    REMINDER_URL : "https://reminder.${var.stage}.anabode.net",
    CONTRACTOR_URL : "https://contractor.${var.stage}.anabode.net",
    QUICKVIEW_URL : "https://quickview.${var.stage}.anabode.net",
    CHAT_GRAPH_URL : "chat-server.${var.stage}.anabode.net",
  })
}

resource "aws_s3_object" "config_file" {
  bucket                 = module.dashboard_bucket.s3_bucket_id
  key                    = "config.js"
  content_type           = "application/javascript"
  content                = local.config_content
  acl                    = "public-read"
  server_side_encryption = "AES256"
  cache_control          = "no-cache, no-store, must-revalidate"
  source_hash            = md5(local.config_content)
}

output "config_output" {
  value = local.config_content
}

output "idp_pool_id" {
  value = data.aws_cognito_user_pools.default.ids
}
