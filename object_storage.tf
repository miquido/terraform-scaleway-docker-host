resource "scaleway_object_bucket" "walg" {
  name   = "${var.project}-${var.environment}-walg-backups"
  region = var.region

  tags = {
    Name        = "${var.project}-${var.environment}-walg-backups"
    Project     = var.project
    Environment = var.environment
  }

  lifecycle_rule {
    id      = "expire-old-backups"
    enabled = true

    expiration {
      days = var.walg_backup_retention_days
    }
  }
}