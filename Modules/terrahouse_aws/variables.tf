variable "user_uuid" {
    description = "The UUID of the user"
    type = string
    default     = "example-user-uuid"
    validation {
      condition     = can(regex("^[a-z0-9.-]*$", var.user_uuid))
      error_message = "User UUID must match the specified pattern."
    }   
}

variable "bucket_name" {
  description = "The name of the AWS S3 bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]*$", var.bucket_name))
    error_message = "Invalid bucket name. Bucket names can only contain lowercase letters, numbers, hyphens, and periods."
  }
}

# can(regex ("^[a-z0-9][a-z0-9]*[a-z0-9]$", var.bucket_name)) 

variable "index_html_filepath" {
  description = "The filepath for index.html"
  type = string

  validation {
    condition = fileexists(var.index_html_filepath)
    error_message = "The provided path for index.html does not exist"
  }
}

variable "error_html_filepath" {
  description = "The filepath for error.html"
  type = string

  validation {
    condition = fileexists(var.error_html_filepath)
    error_message = "The provided path for error.html does not exist"
  }
}