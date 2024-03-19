
# Define the VPC resource
resource "ibm_is_vpc" "lspoc_vpc" {
  name        = "lspoc-vpc"

}

# Define the VPC Subnet
resource "ibm_is_subnet" "lspoc-subnet" {
  name            = "lspoc-subnet"
  vpc             = ibm_is_vpc.lspoc_vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
}

# Output the VPC details
output "vpc_details" {
  value = ibm_is_vpc.lspoc_vpc
}