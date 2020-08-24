output "file_storage_export_id" {
    value = oci_file_storage_export.test_export.id
}

output "mount_target_private_ip_ids" {
    value = oci_file_storage_mount_target.test_mount_target.private_ip_ids
}

output "path_to_nuget" {
    value = oci_file_storage_export.test_export.path
}