resource "scaleway_registry_namespace" "default" {
  name       = "${var.project}-${var.environment}"
  region     = var.region
  is_public  = false
}

resource "scaleway_iam_application" "registry" {
  name        = "${var.project}-${var.environment}-registry"
  description = "Registry access for docker-compose-runner"
}

resource "scaleway_iam_policy" "registry" {
  name           = "${var.project}-${var.environment}-registry"
  application_id = scaleway_iam_application.registry.id

  rule {
    project_ids          = [var.project_id]
    permission_set_names = ["ContainerRegistryFullAccess"]
  }
}

resource "scaleway_iam_api_key" "registry" {
  application_id = scaleway_iam_application.registry.id
  description    = "Registry access for VM docker login"
}
