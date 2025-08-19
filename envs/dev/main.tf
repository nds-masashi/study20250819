variable "resourceName" {}
variable "specificAddress" {}
variable "cidr1" {}
variable "cidr2" {}
variable "subnet1" {}
variable "subnet2" {}

module "network1" {
  source = "../../modules/network"

  resourceName      = "${var.resourceName}-1"
  vpc_cidr_block    = var.cidr1
  subnet_cidr_block = var.subnet1
}

module "network2" {
  source = "../../modules/network"

  resourceName      = "${var.resourceName}-2"
  vpc_cidr_block    = var.cidr2
  subnet_cidr_block = var.subnet2
}

module "ec21" {
  source = "../../modules/ec2"

  resourceName    = "${var.resourceName}-1"
  specificAddress = var.specificAddress
  vpc_id          = module.network1.vpc_id
  subnet_id       = module.network1.subnet_id
}

module "ec22" {
  source = "../../modules/ec2"

  resourceName    = "${var.resourceName}-2"
  specificAddress = var.subnet1
  vpc_id          = module.network2.vpc_id
  subnet_id       = module.network2.subnet_id
}

module "peering" {
  source = "../../modules/peering"

  resourceName      = var.resourceName
  vpc_id_1          = module.network1.vpc_id
  vpc_id_2          = module.network2.vpc_id
  aws_route_table_1 = module.network1.route_table_id
  aws_route_table_2 = module.network2.route_table_id
  vpc_cidr_block_1  = var.cidr1
  vpc_cidr_block_2  = var.cidr2
}
