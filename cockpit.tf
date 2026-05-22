resource "scaleway_cockpit_source" "metrics" {
  count = var.enable_alloy ? 1 : 0

  project_id     = var.project_id
  name           = "${var.project}-${var.environment}-metrics"
  type           = "metrics"
  retention_days = var.cockpit_metrics_retention_days
}

resource "scaleway_cockpit_token" "alloy" {
  count = var.enable_alloy ? 1 : 0

  project_id = var.project_id
  name       = "${var.project}-${var.environment}-alloy"
  scopes {
    write_metrics = true
  }
}