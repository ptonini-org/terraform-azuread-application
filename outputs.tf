output "this" {
  value = azuread_application_registration.this
}

output "passwords" {
  value = {for k, v in azuread_application_password.this: k => v.value }
}