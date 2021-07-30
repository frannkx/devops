
module "vcn" {
    source = "./vcn"
    compartment_id = "${var.compartment_id}"
    tenancy_ocid = "${var.tenancy_ocid}"
    vcn_dns_name = "${var.vcn_dns_name}"
    label_prefix = "${var.label_prefix}"
    vcn_name = "${var.vcn_name}"
    vcn_cidr = "${var.vcn_cidr}"
    subnet_cidr = "${var.subnet_cidr}"
    availability_domains = "${var.availability_domains}"
}