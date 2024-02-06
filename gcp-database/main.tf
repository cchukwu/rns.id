##rns.id/gcp-database/main.tf

data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config = {
    bucket  = "rns-state-devops-rns"
    prefix  = "terraform/state/gcp-vpc"
  }
}

module "database" {
  source            = "../modules/database"
  instance_name     = "rns-db"
  database_version  = "POSTGRES_12"
  region            = var.region
  tier              = "db-f1-micro"
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets           = [
    data.terraform_remote_state.vpc.outputs.public_subnet_id,
    data.terraform_remote_state.vpc.outputs.private_subnet_id
  ]
}

