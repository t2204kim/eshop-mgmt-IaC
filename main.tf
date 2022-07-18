
module "vpc" {
  source          = "./vpc_module"
  cluster_name    = var.cluster_name
}


module "eks" {
  source = "./eks_module"

  cluster_name      = var.cluster_name
  node_type         = var.node_type
  node_desired_size = var.node_desired_size
  node_max_size     = var.node_max_size
  node_min_size     = var.node_min_size
  aws_region        = var.aws_region

  vpc_id     = module.vpc.vpc_id
  subnet_id1 = module.vpc.private_subnet_id[0]
  subnet_id2 = module.vpc.private_subnet_id[1]
}

