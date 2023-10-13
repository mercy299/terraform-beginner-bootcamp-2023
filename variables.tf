variable "teacherseat_user_uuid" {
  type = string
}
variable "terratowns_access_token" {
  type = string
}
variable "terratowns_endpoint" {
  type = string
}
# variable "bucket_name" {
#   type = string
# }
# variable "afang_public_path" {
#   type = string
# }
# variable "sylvanesso_public_path" {
#   type = string
# }

# variable "error_html_filepath" {
#   type = string
# }

# variable "afang_content_version" {
#   type = number
# }
# variable "sylvanesso_content_version" {
#   type = number
# }
# variable "content_version" {
#   type = number
# }

# variable "assets_path" {
#   description = "Path to assets folder"
#   type = string
# }
variable "afang" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "sylvanesso" {
  type = object({
    public_path = string
    content_version = number
  })
}