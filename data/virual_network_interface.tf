
resource "ibm_is_virtual_network_interface" "lspoc-vni"{
     name  = "lspoc-vni"
    allow_ip_spoofing       = false
    enable_infrastructure_nat   = true
    primary_ip {
        auto_delete       = false
    address             = "10.240.0.8"
    }
    subnet   = ibm_is_subnet.lspoc.id
}
