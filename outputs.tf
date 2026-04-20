output "public_ip" {
  description = "Public IP address of the instance"
  value       = scaleway_instance_ip.public.address
}

output "domain" {
  description = "Base domain"
  value       = var.domain
}

output "registry_endpoint" {
  description = "Scaleway container registry endpoint"
  value       = scaleway_registry_namespace.default.endpoint
}

output "oidc_endpoint" {
  description = "OIDC function endpoint for GitLab CI"
  value       = module.oidc.oidc_endpoint
}
