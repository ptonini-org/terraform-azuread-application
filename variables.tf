variable "display_name" {}

variable "description" {
  default = null
}

variable "sign_in_audience" {
  default = null
}

variable "group_membership_claims" {
  type = set(string)
  default = null
}

variable "logout_url" {
  default = null
}

variable "implicit_access_token_issuance_enabled" {
  default = true
  nullable = false
}


variable "implicit_id_token_issuance_enabled" {
  default = true
  nullable = false
}

variable "redirect_uris" {
  type = map(object({
    type = optional(string)
    redirect_uris = set(string)
  }))
  default = {}
  nullable = false
}

variable "passwords" {
  type = map(object({
    display_name = optional(string)
    rotate_when_changes = optional(map(string))
  }))
  default = {}
  nullable = false
}

variable "federated_credentials" {
  type = map(object({
    display_name = optional(string)
    issuer       = string
    subject      = string
    audiences    = optional(set(string), ["api://AzureADTokenExchange"])
  }))
  default = {}
  nullable = false
}