terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "4.56.0"
        }
    }
}
provider "aws"{
    region = "${var.region}"
}
module "autoscalinggroup_module" {
  source = "../modules/autoscalinggroup"
  lb_tg_arn = "${module.loadbalancer_module.lb_tg_arn}"
  public_subnet_id_1 = "${module.networking_module.public_subnet_id_1}"
  public_subnet_id_2 = "${module.networking_module.public_subnet_id_2}"
  security_gp_1 = "${module.networking_module.sg_id_1}"
  ec2_type = "${var.ec2_type}"
}
module "networking_module" {
  source = "../modules/networking"
  vpc_cidr = "${var.vpc_cidr}"
  tenancy = "${var.tenancy}"
  subnet_cidrs = "${var.subnet_cidrs}"
  avail_zones = "${var.avail_zones}"
  ingress_ports = "${var.ingress_ports}"
  protocol = "${var.protocol}"
}
module "loadbalancer_module"{
  source = "../modules/loadbalancer"
  security_gp_2 = "${module.networking_module.sg_id_2}"
  public_subnet_id_1 = "${module.networking_module.public_subnet_id_1}"
  public_subnet_id_2 = "${module.networking_module.public_subnet_id_2}"
  vpc_id = "${module.networking_module.vpc_id}"
  cert01_arn = "${module.route53_module.cert01_arn}"
}
module "route53_module" {
  source = "../modules/route53"
  lb_dns_name = "${module.loadbalancer_module.lb_dns_name}"
  lb_zone_id = "${module.loadbalancer_module.lb_zone_id}"
  hosted_zone_id = "${var.hosted_zone_id}"
}