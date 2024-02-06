##rns.id/gcp-vpc/main.tf

module "vpc" {
  source = "./modules/vpc"
  name   = "my-vpc"
}

module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_name  = "my-public-subnet"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_name = "my-private-subnet"
  private_subnet_cidr = "10.0.2.0/24"
  region              = "us-central1"
}

module "firewall" {
  source  = "./modules/firewall"
  network = module.vpc.vpc_id
}
