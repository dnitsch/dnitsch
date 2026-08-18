locals {
  domain_name = "${var.dns_record}.${var.dns_zone}"
  content_types = {
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    json = "application/json"
    png  = "image/png"
    jpg  = "image/jpeg"
    ico  = "image/x-icon"
    svg  = "image/svg+xml"
    pdf  = "application/pdf"
  }
}
