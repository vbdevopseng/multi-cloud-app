output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "webapp_url" {
  value = azurerm_app_service.app.default_site_hostname
}
