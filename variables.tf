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
  description = "Base domain for wildcard certificate and routing (e.g. dmc.miquido.dev)"
  type        = string
}

variable "acme_email" {
  description = "Email for Let's Encrypt ACME registration"
  type        = string
}

variable "dns_challenge_provider" {
  description = "Traefik ACME DNS challenge provider (e.g. route53, cloudflare)"
  type        = string
  default     = "route53"
}

variable "dns_challenge_env" {
  description = "Environment variables required by the DNS challenge provider"
  type        = map(string)
  sensitive   = true
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
  default = "ghcr.io/miquido/gitlab-docker-compose-host:v1.0.2"
}

variable "registry_url" {
  description = "Docker registry hostname to authenticate against"
  type        = string
}

variable "registry_username" {
  description = "Username for docker login"
  type        = string
}

variable "registry_password" {
  description = "Password for docker login"
  type        = string
  sensitive   = true
}

variable "docker_prune_schedule" {
  description = "Cron schedule for Docker image pruning via Ofelia. Set to empty string to disable."
  type        = string
  default     = "0 3 * * *"
}

variable "enable_alloy" {
  description = "Enable Grafana Alloy metrics collection to Scaleway Cockpit."
  type        = bool
  default     = true
}

variable "cockpit_metrics_retention_days" {
  description = "Number of days to retain Traefik metrics in Scaleway Cockpit."
  type        = number
  default     = 30
}

variable "walg_backup_retention_days" {
  description = "Number of days to retain WAL-G backups in Object Storage before automatic deletion."
  type        = number
  default     = 30
}

variable "ssh_public_keys" {
  description = "List of SSH public keys added to the dynamic user's authorized_keys on the VM."
  type        = list(string)
  default     = []
}
