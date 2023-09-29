variable "user_uuid"{
    description = "The UUID of the user"
    type = string
    validation {
      name = "is-valid-uuid"
      condition = can(regex())
    }   
}