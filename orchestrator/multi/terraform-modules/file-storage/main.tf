resource "oci_file_storage_file_system" "test_file_system" {
    #Required
    availability_domain = var.file_system_availability_domain
    compartment_id = var.compartment_id

    #Optional
    display_name = var.file_system_display_name
}

resource "oci_file_storage_mount_target" "test_mount_target" {
    #Required
    availability_domain = var.mount_target_availability_domain
    compartment_id = var.compartment_id
    subnet_id = var.mount_target_subnet

    #Optional
    display_name = var.mount_target_display_name
}

resource "oci_file_storage_export" "test_export" {
    #Required
    export_set_id = oci_file_storage_mount_target.test_mount_target.export_set_id
    file_system_id = oci_file_storage_file_system.test_file_system.id
    path = var.export_path

    #Optional
    export_options {
        #Required
        source = var.export_export_options_source

        #Optional
        access = var.export_export_options_access
        #anonymous_gid = var.export_export_options_anonymous_gid
        #anonymous_uid = var.export_export_options_anonymous_uid
        identity_squash = var.export_export_options_identity_squash
        require_privileged_source_port = var.export_export_options_require_privileged_source_port
    }
}