module "vpc" {
  source  = "./modules/vpc"
  #version = "~> 1.25"

  name               = "us-east-1"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# module "iam" {
#   source  = "./modules/iam"
#   #version = "~> 1.25"
# }


module "cluster" {
  source  = "./modules/cluster"
  #version = "~> 1.25"

  name       = "sayaam-eks"

  vpc_config = module.vpc.config
  #iam_config = module.iam.config
  ####----enable below if you want the cluster api to public ---###
  endpoint_public_access = "true"
  endpoint_public_access_cidrs = "0.0.0.0/0"

}
#if you want to use the asg then below code
# module "node_group" {
#   source  = "./modules/asg_node_group"
#   #version = "~> 1.25"

#   cluster_config = module.cluster.config

#   max_size           = 60
#   instance_family    = "burstable"
#   instance_size      = "medium"
# }