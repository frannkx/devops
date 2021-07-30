provider "oci"{
    version = ">=3.0.0"
    auth    = "InstancePrincipal"
    region  = "${var.region}"
}

terraform{
    backend "http" {
        update_method   = "PUT"
        address         = "<bucket-address>"
    }
}