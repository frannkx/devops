terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  region              = var.region
  auth                = "ApiKey"
  config_file_profile = "DEFAULT"
}

resource "oci_core_vcn" "internal" {
  dns_label      = "internal"
  cidr_block     = "172.16.0.0/20"
  compartment_id = var.compartment_id
  display_name   = "Dev VCN"
}

resource "oci_core_subnet" "dev" {
  vcn_id                      = oci_core_vcn.internal.id
  cidr_block                  = "172.16.0.0/24"
  compartment_id              = var.compartment_id
  display_name                = "Developer's subnet 1"
  prohibit_public_ip_on_vnic  = true
  dns_label                   = "dev"
}
