#data "ibm_is_ssh_key" "lspoc-sshkey" {
#  name = "ls-poc-sshkey"
#}
resource "ibm_is_ssh_key" "ls-poc-key01" {
  name       = "ls-poc-key01"
 public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCM0Umlo6KEEQl3o5ybha97DkhMtP7/KeNb9M/Ve1pvCNc2jl4h43j+7fOW5Mp14DfMWH1ZD1wW5B5noyZyLMFxgxX+qoDupgvyFVDSHRrxoSi4x3ulQJBUY3PPuKF3MCDo6Rw70CePUy6w53qLqOHGaBssaOAq4fkm2oS/1Emna1Hv1PQcCTLDDfdikkrlkVBU7o7xEs9Qw/BcHhg0+Y7CqqNbmMWQaAZnChQH4NDxaCuyTgBG4yOu+LL0jS/8W2yst7BO7ryqrqRZ11qNSslZmi6lv2I/8d3uoEjnh/YukXXINVXeo7gNl66AtynXbRRLmFK2PzHXpMfQP6X1OZSn"
}

resource "ibm_is_instance" "my_instance" {
  name           = "lspoc-instance"
  image          = "r006-f259b449-f3d4-4924-8d67-61201f728068" 
  profile        = "bx2-2x8"  
  primary_network_interface {
    subnet = ibm_is_subnet.lspoc-subnet.id
    primary_ipv4_address = "10.240.0.101" 
    allow_ip_spoofing = true
  }
     vpc  = ibm_is_vpc.lspoc_vpc.id
     zone = ibm_is_subnet.lspoc-subnet.zone
     keys = [ibm_is_ssh_key.ls-poc-key01.id]

}
resource "ibm_is_floating_ip" "lspoc-floatip" {
  name   = "lspoc-floatip-my-instance"
  target = ibm_is_instance.my_instance.primary_network_interface[0].id
}