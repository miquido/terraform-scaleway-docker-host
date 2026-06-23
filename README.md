# scaleway-docker-host <a href="https://miquido.com"><img align="right" src="https://cdn.miquido.dev/miquido-logo.png" width="150" /></a>

Provisions a Scaleway VM as a Docker host with Traefik, OIDC auth, WAL-G backups, and Grafana Alloy metrics

## Development

```bash
make init   # run once after cloning
make readme # regenerate README.md
make lint   # lint terraform code
```

## Usage

```hcl
module "docker_host" {
  source = "git@gitlab.miquido.com:miquido/terraform/scaleway-docker-host.git?ref=v1.0.0"

  project         = "my-project"
  project_id      = var.scaleway_project_id
  organization_id = var.scaleway_organization_id
  environment     = "production"

  domain       = "dmc.example.com"
  acme_email   = "ops@example.com"
  ssh_ip_range = "0.0.0.0/0"

  oidc_jwks_url      = "https://gitlab.com/-/jwks"
  oidc_audience      = "https://gitlab.com"
  oidc_expected_subs = ["project_path:my-group/my-project:ref_type:branch:ref:main"]
  ip_allowlist       = "0.0.0.0/0"

  registry_url      = "registry.gitlab.com"
  registry_username = "gitlab-ci-token"
  registry_password = var.registry_password

  dns_challenge_provider = "route53"
  dns_challenge_env = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | ~> 2.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0 |
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | ~> 2.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_docker_host"></a> [docker\_host](#module\_docker\_host) | git::https://github.com/miquido/terraform-docker-host.git | tags/1.2.1 |

## Resources

| Name | Type |
| ---- | ---- |
| [random_password.dynamic_user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [scaleway_block_volume.data](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/block_volume) | resource |
| [scaleway_cockpit_source.metrics](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/cockpit_source) | resource |
| [scaleway_cockpit_token.alloy](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/cockpit_token) | resource |
| [scaleway_iam_api_key.walg](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_api_key) | resource |
| [scaleway_iam_application.walg](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_application) | resource |
| [scaleway_iam_policy.walg](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_policy) | resource |
| [scaleway_instance_ip.public](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_ip) | resource |
| [scaleway_instance_security_group.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_security_group) | resource |
| [scaleway_instance_server.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_server) | resource |
| [scaleway_object_bucket.walg](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/object_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_acme_email"></a> [acme\_email](#input\_acme\_email) | Email for Let's Encrypt ACME registration | `string` | n/a | yes |
| <a name="input_cockpit_metrics_retention_days"></a> [cockpit\_metrics\_retention\_days](#input\_cockpit\_metrics\_retention\_days) | Number of days to retain Traefik metrics in Scaleway Cockpit. | `number` | `30` | no |
| <a name="input_data_volume_iops"></a> [data\_volume\_iops](#input\_data\_volume\_iops) | n/a | `number` | `5000` | no |
| <a name="input_data_volume_size_in_gb"></a> [data\_volume\_size\_in\_gb](#input\_data\_volume\_size\_in\_gb) | n/a | `number` | `20` | no |
| <a name="input_dns_challenge_env"></a> [dns\_challenge\_env](#input\_dns\_challenge\_env) | Environment variables required by the DNS challenge provider | `map(string)` | n/a | yes |
| <a name="input_dns_challenge_provider"></a> [dns\_challenge\_provider](#input\_dns\_challenge\_provider) | Traefik ACME DNS challenge provider (e.g. route53, cloudflare) | `string` | `"route53"` | no |
| <a name="input_docker_compose_runner_image"></a> [docker\_compose\_runner\_image](#input\_docker\_compose\_runner\_image) | n/a | `string` | `"miquido/gitlab-docker-compose-host:172950-746ccb39"` | no |
| <a name="input_docker_prune_schedule"></a> [docker\_prune\_schedule](#input\_docker\_prune\_schedule) | Cron schedule for Docker image pruning via Ofelia. Set to empty string to disable. | `string` | `"0 3 * * *"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Base domain for wildcard certificate and routing (e.g. dmc.miquido.dev) | `string` | n/a | yes |
| <a name="input_enable_alloy"></a> [enable\_alloy](#input\_enable\_alloy) | Enable Grafana Alloy metrics collection to Scaleway Cockpit. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"DEV1-S"` | no |
| <a name="input_ip_allowlist"></a> [ip\_allowlist](#input\_ip\_allowlist) | CIDR range allowed to access the docker-compose-runner endpoint | `string` | n/a | yes |
| <a name="input_oidc_audience"></a> [oidc\_audience](#input\_oidc\_audience) | Expected OIDC audience for docker-compose-runner | `string` | n/a | yes |
| <a name="input_oidc_expected_subs"></a> [oidc\_expected\_subs](#input\_oidc\_expected\_subs) | List of expected OIDC subjects for docker-compose-runner | `list(string)` | n/a | yes |
| <a name="input_oidc_jwks_url"></a> [oidc\_jwks\_url](#input\_oidc\_jwks\_url) | JWKS URL for docker-compose-runner OIDC authentication | `string` | n/a | yes |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"pl-waw"` | no |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Password for docker login | `string` | n/a | yes |
| <a name="input_registry_url"></a> [registry\_url](#input\_registry\_url) | Docker registry hostname to authenticate against | `string` | n/a | yes |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Username for docker login | `string` | n/a | yes |
| <a name="input_root_volume_size_in_gb"></a> [root\_volume\_size\_in\_gb](#input\_root\_volume\_size\_in\_gb) | n/a | `number` | `20` | no |
| <a name="input_ssh_ip_range"></a> [ssh\_ip\_range](#input\_ssh\_ip\_range) | CIDR allowed SSH access | `string` | n/a | yes |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | List of SSH public keys added to the dynamic user's authorized\_keys on the VM. | `list(string)` | `[]` | no |
| <a name="input_walg_backup_retention_days"></a> [walg\_backup\_retention\_days](#input\_walg\_backup\_retention\_days) | Number of days to retain WAL-G backups in Object Storage before automatic deletion. | `number` | `30` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_block_volume_id"></a> [block\_volume\_id](#output\_block\_volume\_id) | Persistent data block volume ID |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP address of the instance |
| <a name="output_walg_backup_bucket"></a> [walg\_backup\_bucket](#output\_walg\_backup\_bucket) | Object Storage bucket name for WAL-G backups |
<!-- END_TF_DOCS -->

## License

[MIT](LICENSE)
