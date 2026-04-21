resource "random_password" "dynamic_user" {
  length  = 24
  special = false
}

module "docker_host" {
  source = "git::https://github.com/miquido/terraform-docker-host.git?ref=tags/1.0.3"

  domain                      = var.domain
  acme_email                  = var.acme_email
  dns_challenge_provider      = var.dns_challenge_provider
  dns_challenge_env           = var.dns_challenge_env
  oidc_jwks_url               = var.oidc_jwks_url
  oidc_audience               = var.oidc_audience
  oidc_expected_subs          = join(",", var.oidc_expected_subs)
  ip_allowlist                = var.ip_allowlist
  docker_compose_runner_image = var.docker_compose_runner_image
  passwd_hash                 = bcrypt(random_password.dynamic_user.result)
  registry_url                = var.registry_url
  registry_username           = var.registry_username
  registry_password           = var.registry_password
  block_device                = "/dev/sdb"
}

resource "scaleway_instance_security_group" "main" {
  zone                    = "${var.region}-1"
  name                    = "${var.project}-${var.environment}-dynamic-env"
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action   = "accept"
    port     = 22
    ip_range = var.ssh_ip_range
  }

  inbound_rule {
    action = "accept"
    port   = 80
  }

  inbound_rule {
    action = "accept"
    port   = 443
  }

  inbound_rule {
    action = "accept"
    port   = 5432
  }
}

resource "scaleway_instance_ip" "public" {
  zone = "${var.region}-1"
}

resource "scaleway_instance_server" "main" {
  name              = "${var.project}-${var.environment}"
  image             = "ubuntu_jammy"
  type              = var.instance_type
  zone              = "${var.region}-1"
  ip_id             = scaleway_instance_ip.public.id
  security_group_id = scaleway_instance_security_group.main.id

  root_volume {
    size_in_gb = var.root_volume_size_in_gb
  }

  user_data = {
    cloud-init = module.docker_host.cloud_init_config
  }

  additional_volume_ids = [scaleway_block_volume.data.id]

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "scaleway_block_volume" "data" {
  iops       = var.data_volume_iops
  name       = "${var.project}-${var.environment}-data"
  size_in_gb = var.data_volume_size_in_gb
  zone       = "${var.region}-1"

  lifecycle {
    ignore_changes = [snapshot_id]
  }
}
