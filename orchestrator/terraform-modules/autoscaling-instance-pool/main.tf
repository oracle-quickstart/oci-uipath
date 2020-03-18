resource "oci_core_instance_pool" "test_instance_pool" {
    #Required
    compartment_id = "${var.compartment_id}"
    instance_configuration_id = "${oci_core_instance_configuration.test_instance_configuration.id}"
    placement_configurations {
        #Required
        availability_domain = "${var.instance_pool_placement_configurations_availability_domain}"
        primary_subnet_id = "${oci_core_subnet.test_subnet.id}"

        #Optional
        fault_domains = "${var.instance_pool_placement_configurations_fault_domains}"
        secondary_vnic_subnets {
            #Required
            subnet_id = "${oci_core_subnet.test_subnet.id}"

            #Optional
            display_name = "${var.instance_pool_placement_configurations_secondary_vnic_subnets_display_name}"
        }
    }
    size = "${var.instance_pool_size}"

    #Optional
    display_name = "${var.instance_pool_display_name}"
    load_balancers {
        #Required
        backend_set_name = "${oci_load_balancer_backend_set.test_backend_set.name}"
        load_balancer_id = "${oci_load_balancer_load_balancer.test_load_balancer.id}"
        port = "${var.instance_pool_load_balancers_port}"
        vnic_selection = "${var.instance_pool_load_balancers_vnic_selection}"
    }
}

resource "oci_core_instance_configuration" "test_instance_configuration" {
    #Required
    compartment_id = "${var.compartment_id}"

    #Optional
    display_name = "${var.instance_configuration_display_name}"
    instance_details {
        #Required
        instance_type = "${var.instance_configuration_instance_details_instance_type}"

        launch_details {

            #Optional
            availability_domain = "${var.instance_configuration_instance_details_launch_details_availability_domain}"
            compartment_id = "${var.compartment_id}"
            create_vnic_details {

                #Optional
                assign_public_ip = "${var.instance_configuration_instance_details_launch_details_create_vnic_details_assign_public_ip}"
                display_name = "${var.instance_configuration_instance_details_launch_details_create_vnic_details_display_name}"
                hostname_label = "${var.instance_configuration_instance_details_launch_details_create_vnic_details_hostname_label}"
                nsg_ids = "${var.instance_configuration_instance_details_launch_details_create_vnic_details_nsg_ids}"
                private_ip = "${var.instance_configuration_instance_details_launch_details_create_vnic_details_private_ip}"
                subnet_id = "${oci_core_subnet.test_subnet.id}"
            }
            display_name = "${var.instance_configuration_instance_details_launch_details_display_name}"
            fault_domain = "${var.instance_configuration_instance_details_launch_details_fault_domain}"
            metadata = "${var.instance_configuration_instance_details_launch_details_metadata}"
            shape = "${var.instance_configuration_instance_details_launch_details_shape}"
            source_details {
                #Required
                source_type = "${var.instance_configuration_instance_details_launch_details_source_details_source_type}"
                image_id = "${oci_core_image.test_image.id}"
            }
        }
    }
    instance_id = "${oci_core_instance.test_instance.id}"
    source = "${var.instance_configuration_source}"
}