variable "vpc_cidr" {}
variable "tenancy" {}
variable "subnet_cidrs" {
    type = list(string)
}
variable "avail_zones" {
    type = list(string)
}
variable "ingress_ports" {
    type = list(string)
}
variable "protocol" {}