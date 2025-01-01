resource "azuread_application_registration" "this" {
  display_name                           = var.display_name
  description                            = var.description
  sign_in_audience                       = var.sign_in_audience
  logout_url                             = var.logout_url
  group_membership_claims                = var.group_membership_claims
  implicit_access_token_issuance_enabled = var.implicit_access_token_issuance_enabled
  implicit_id_token_issuance_enabled     = var.implicit_id_token_issuance_enabled
}

resource "azuread_application_redirect_uris" "this" {
  for_each       = var.redirect_uris
  application_id = azuread_application_registration.this.id
  type           = coalesce(each.value.type, each.key)
  redirect_uris  = each.value.redirect_uris
}

resource "azuread_application_password" "this" {
  for_each            = var.passwords
  application_id      = azuread_application_registration.this.id
  display_name        = coalesce(each.value.display_name, each.key)
  rotate_when_changed = each.value.rotate_when_changes
}

resource "azuread_application_federated_identity_credential" "this" {
  for_each              = var.federated_credentials
  application_id        = azuread_application_registration.this.id
  display_name          = coalesce(each.value.display_name, each.key)
  audiences             = each.value.audiences
  issuer                = each.value.issuer
  subject               = each.value.subject
}
