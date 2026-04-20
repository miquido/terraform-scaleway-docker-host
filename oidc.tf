module "oidc" {
  source              = "git::https://github.com/miquido/terraform-scw-oidc.git?ref=tags/1.1.0"
  environment         = var.environment
  project             = var.project
  scw_organization_id = var.organization_id
  scw_project_id      = var.project_id
  scw_region          = var.region
  gitlab_jwks_url     = var.registry_oidc_provider_jwks_url
  oidc = [
    {
      application_id = scaleway_iam_application.registry.id
      aud            = var.registry_oidc_audience
      sub            = var.registry_oidc_sub
      session_length = 10
    }
  ]
  function_domain = "oidc.${var.domain}"
}
