resource "scaleway_iam_application" "walg" {
  name = "${var.project}-${var.environment}-walg"
}

resource "scaleway_iam_api_key" "walg" {
  application_id     = scaleway_iam_application.walg.id
  description        = "WAL-G backup access for ${var.project}-${var.environment}"
  default_project_id = var.project_id
}

resource "scaleway_iam_policy" "walg" {
  name           = "${var.project}-${var.environment}-walg"
  application_id = scaleway_iam_application.walg.id

  rule {
    project_ids          = [var.project_id]
    permission_set_names = ["ObjectStorageFullAccess"]
  }
}