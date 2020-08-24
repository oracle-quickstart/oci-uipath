resource "oci_core_instance_pool" "test_instance_pool" {
    #Required
    #depends_on = [var.pool_depends_on]
    compartment_id = var.compartment_id
    instance_configuration_id = oci_core_instance_configuration.test_instance_configuration.id
    placement_configurations {
        #Required
        availability_domain = var.availability_domain
        #TODO remove hardcoded subnet id
        #primary_subnet_id = "${oci_core_subnet.test_subnet.id}"
        primary_subnet_id  = var.subnet_id
        # #Optional
        # fault_domains = var.instance_pool_placement_configurations_fault_domains
        # secondary_vnic_subnets {
        #     #Required
        #     subnet_id = var.subnet_id

        #     #Optional
        #     display_name = var.instance_pool_placement_configurations_secondary_vnic_subnets_display_name
        # }
    }
    size = var.instance_pool_size

    #Optional
    display_name = var.instance_pool_display_name
    load_balancers {
        #Required
        backend_set_name = var.backend_set_name
        load_balancer_id = var.load_balancer_id
        port = var.instance_pool_load_balancers_port
        vnic_selection = var.instance_pool_load_balancers_vnic_selection
    }
}

resource "oci_core_instance_configuration" "test_instance_configuration" {
    #Required
    compartment_id = var.compartment_id

    #Optional
    #display_name = var.instance_configuration_display_name
    instance_details {
        #Required
        instance_type = var.instance_configuration_instance_details_instance_type

        launch_details {

            #Optional
            availability_domain = var.availability_domain
            compartment_id = var.compartment_id
            create_vnic_details {

                #Optional
                assign_public_ip = var.instance_configuration_instance_details_launch_details_create_vnic_details_assign_public_ip
                #display_name = var.instance_configuration_instance_details_launch_details_create_vnic_details_display_name
                #hostname_label = var.instance_configuration_instance_details_launch_details_create_vnic_details_hostname_label
                nsg_ids = [var.instance_configuration_instance_details_launch_details_create_vnic_details_nsg_ids]
                #private_ip = var.instance_configuration_instance_details_launch_details_create_vnic_details_private_ip
                subnet_id = var.subnet_id
            }
            #display_name = var.instance_configuration_instance_details_launch_details_display_name
            #fault_domain = var.instance_configuration_instance_details_launch_details_fault_domain
            #TODO add metadata for orchestrator
            metadata = {
                user_data = data.template_cloudinit_config.cloudinit_config.rendered
            }
            shape = var.instance_configuration_instance_details_launch_details_shape
            source_details {
                #Required
                source_type = var.instance_configuration_instance_details_launch_details_source_details_source_type
                image_id = var.image_id
            }
        }
    }
    instance_id = var.oci_core_instance_id
    source = var.instance_configuration_source
}

data "template_file" "orchestrator_setup" {
  template = file("./user_data.txt")
  vars = {
    instance_username         = var.instance_username
    instance_password         = var.instance_password
    orchestratorVersion       = var.orchestratorVersion
    orchestratorFolder        = "C:\\Program Files\\UiPath\\Orchestrator"
    databaseServerName        = var.sqlserver
    databaseName              = var.databaseName
    databaseUserName          = (var.databaseType == "New Paid SQL Server Standard") ? "uipath" : var.databaseUserName
    databaseUserPassword      = var.databaseUserPassword
    passphrase                = var.passphrase
    orchestratorAdminPassword = var.orchestratorAdminPassword
    redisServerHost           = var.redisServerHost
    mount_target_ip           = var.mount_target_ip
    nuget_path                = var.nuget_path
    user_ocid                 = var.user_ocid
    fingerprint               = var.fingerprint
    key_file                  = var.key_file
    tenancy                   = var.tenancy
    region                    = var.region
    compartment_id            = var.compartment_id
    instance_pool_name        = var.instance_pool_display_name
  }
}

data "template_cloudinit_config" "cloudinit_config" {
  gzip          = false
  base64_encode = true

  part {
    filename     = "cloudinit.ps1"
    content_type = "text/x-shellscript"
    content      = data.template_file.orchestrator_setup.rendered
  }
}
