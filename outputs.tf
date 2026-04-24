output "public_ip" {
  description = "Public IP address of the instance"
  value       = scaleway_instance_ip.public.address
}

output "block_volume_id" {
  description = "Persistent data block volume ID"
  value       = scaleway_block_volume.data.id
}

output "walg_backup_bucket" {
  description = "Object Storage bucket name for WAL-G backups"
  value       = scaleway_object_bucket.walg.name
}
