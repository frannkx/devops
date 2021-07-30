variable "user_ocid" {}

variable "tenancy_ocid" {}

variable "private_key_path" {}

variable "ssh_public_key" {}

variable "fingerprint" {}

variable "compartment_id" {}

variable "vcn_id" {}

variable "region" {}

variable "label_prefix" {}

variable "image_ocid" {}

variable "availability_domains" {
    type = "map"
}

variable "bastion_shape" {}

variable "bastion_subnet_ids" {
    type = "string"
}