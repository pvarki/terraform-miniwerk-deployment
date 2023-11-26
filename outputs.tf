output "dns_name" {
  value       = trimsuffix(azurerm_dns_a_record.this.fqdn, ".")
  description = "FQDN for RASENMAEHER"
}
