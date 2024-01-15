
terraform {
  required_version = ">= 0.14.0"
}

module "compartment" {
  source  = "./modules/compartment"
  global = var.global
  security = var.security
}

module "network" {
  source  = "./modules/network"
  global = var.global
  subnets = var.subnets
  vcn = var.vcn
}

module "loadbalancer" {
  source  = "./modules/loadbalancer"
  global = var.global
  lb = var.lb
  subnets = var.subnets
}

module "security" {
  source  = "./modules/security"
  global = var.global
  vcn_id = module.network.vcn.vcn_id
  ci = var.ci
  subnets = var.subnets
  security = var.security
}

module "container_instance" {
  source  = "./modules/container_instance"
  global = var.global
  ci = var.ci
  subnets = var.subnets
}

module "autonomous_database" {
  source  = "./modules/database"
  global = var.global
  database = var.database
  security = var.security
  #database_nsg_id = module.security.nsgs.database_nsg_id
}