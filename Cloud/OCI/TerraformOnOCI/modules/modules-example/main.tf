


module "vcn" {
    source = "./vnc"
    compartment_id = "${var.compartment_ocid}"
    ...
}

module "bastion" {
    source = "./bastion"
    tenancy_ocid = "${var.tenancy_ocid}"
    ...
}