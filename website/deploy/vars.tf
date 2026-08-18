#########################################################
# Variables

variable "region" {
  default = "eu-west-1"
}

variable "name" {
  default = "site"
}

variable "namespace" {
  default = "dnitsch"
}

variable "attributes" {
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "workspace_iam_role" {
  type        = string
  description = "Base IAM role"
}

variable "dns_iam_role" {
  type        = string
  description = "DNS IAM role"
}

# WEB Dashboard
variable "build_output_path" {
  type        = string
  default     = "../site/public"
  description = "build output directory"
}

variable "log_level" {
  type        = string
  default     = "debug"
  description = "(optional) describe your variable"
}

variable "commit_sha" {
  type        = string
  description = "Commit SHA"
}

variable "commit_ref" {
  type        = string
  description = "Commit ref slug"
}

variable "user_data_storage_bucket" {
  type        = string
  default     = "anabode-dev-shared-user"
  description = "storage bucket for user data"
}

variable "stripe_publishable_key" {
  type        = string
  description = "(optional) describe your variable"
}

variable "firebase_config" {
  type        = string
  description = "(optional) describe your variable"
}

variable "idp_pool_id" {
  type        = string
  description = "IDP Pool Id"
}

# USER_DATA_STORAGE_BUCKET: "${USER_DATA_STORAGE_BUCKET:-anabode-dev-shared-user}",
# STRIPE_PUBLISHABLE_KEY: "${STRIPE_PUBLISHABLE_KEY}",
# FIREBASE_CONFIG: "${FIREBASE_CONFIG}",
# UTILS_URL: "${UTILS_URL}",
# CHAT_URL: "${CHAT_URL}",
# ACCOUNT_URL: "${ACCOUNT_URL}",
# GENERICS_URL: "${GENERICS_URL}",
# LANDLORD_URL: "${LANDLORD_URL}",
# PROPERTY_URL: "${PROPERTY_URL}",
# TENANCY_URL: "${TENANCY_URL}",
# REPAIR_URL: "${REPAIR_URL}",
# REMINDER_URL: "${REMINDER_URL}",
# CONTRACTOR_URL: "${CONTRACTOR_URL}",
# QUICKVIEW_URL: "${QUICKVIEW_URL}"

# DNS
variable "dns_zone" {
  type        = string
  description = "DNS zone name - e.g. dev.anabode.app"
}

variable "dns_record" {
  type        = string
  default     = "dashboard"
  description = "DNS record for the app to be published under"
}
