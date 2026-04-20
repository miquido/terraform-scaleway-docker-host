variable "project" {
  type = string
}

variable "project_id" {
  type = string
}

variable "organization_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type    = string
  default = "pl-waw"
}

variable "instance_type" {
  type    = string
  default = "DEV1-S"
}

variable "root_volume_size_in_gb" {
  type    = number
  default = 20
}

variable "data_volume_size_in_gb" {
  type    = number
  default = 20
}

variable "data_volume_iops" {
  type    = number
  default = 5000
}

variable "ssh_ip_range" {
  description = "CIDR allowed SSH access"
  type        = string
}

variable "domain" {
  description = "Base domain (e.g. dmc.miquido.dev). Wildcard cert will be issued for *.domain."
  type        = string
}

variable "acme_email" {
  description = "Email for Let's Encrypt ACME registration"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 hosted zone ID for the domain"
  type        = string
}

variable "oidc_jwks_url" {
  description = "JWKS URL for docker-compose-runner OIDC authentication"
  type        = string
}

variable "oidc_audience" {
  description = "Expected OIDC audience for docker-compose-runner"
  type        = string
}

variable "oidc_expected_subs" {
  description = "List of expected OIDC subjects for docker-compose-runner"
  type        = list(string)
}

variable "ip_allowlist" {
  description = "CIDR range allowed to access the docker-compose-runner endpoint"
  type        = string
}

variable "docker_compose_runner_image" {
  type    = string
  default = "miquido/gitlab-docker-compose-host:172950-746ccb39"
}

variable "registry_oidc_provider_jwks_url" {
  description = "OIDC provider JWKS URL for CI → Scaleway registry access (e.g. https://gitlab.example.com/.well-known/openid-configuration)"
  type        = string
}

variable "registry_oidc_audience" {
  description = "OIDC audience for registry access"
  type        = string
}

variable "registry_oidc_sub" {
  description = "OIDC subject pattern for registry access (e.g. project_path:myorg/*)"
  type        = string
}
