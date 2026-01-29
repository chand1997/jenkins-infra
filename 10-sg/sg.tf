module "sg_mysql" {
  source         = "git::https://github.com/DAWS-82S/terraform-aws-securitygroup.git?ref=main"
  project_name   = "expense"
  environment    = "dev"
  sg_name        = "mysql"
  sg_description = "mysql"
  vpc_id         = local.vpc_id
  common_tags    = {}

}

module "sg_eks_control" {
  source         = "git::https://github.com/DAWS-82S/terraform-aws-securitygroup.git?ref=main"
  project_name   = "expense"
  environment    = "dev"
  sg_name        = "eks-control-plane"
  sg_description = "eks-control-plane"
  vpc_id         = local.vpc_id
  common_tags    = {}

}

module "sg_eks_node" {
  source         = "git::https://github.com/DAWS-82S/terraform-aws-securitygroup.git?ref=main"
  project_name   = "expense"
  environment    = "dev"
  sg_name        = "eks-nodes"
  sg_description = "eks-nodes"
  vpc_id         = local.vpc_id
  common_tags    = {}

}


module "sg_bastion" {
  source         = "git::https://github.com/DAWS-82S/terraform-aws-securitygroup.git?ref=main"
  project_name   = "expense"
  environment    = "dev"
  sg_name        = "bastion"
  sg_description = "bastion"
  vpc_id         = local.vpc_id
  common_tags    = {}

}


module "sg_ingress_alb" {
  source         = "git::https://github.com/DAWS-82S/terraform-aws-securitygroup.git?ref=main"
  project_name   = "expense"
  environment    = "dev"
  sg_name        = "ingress-alb"
  sg_description = "ingress-alb"
  vpc_id         = local.vpc_id
  common_tags    = {}

}

resource "aws_security_group_rule" "eks_nodes_eks_control_plane" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.sg_eks_node.sg_id
  security_group_id        = module.sg_eks_control.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_eks_nodes" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.sg_eks_control.sg_id
  security_group_id        = module.sg_eks_node.sg_id
}

resource "aws_security_group_rule" "pod_to_pod_within_worker_nodes" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = module.sg_eks_node.sg_id
}


resource "aws_security_group_rule" "bastion_eks_nodes" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id        = module.sg_eks_node.sg_id
}

resource "aws_security_group_rule" "bastion_ingress_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id        = module.sg_ingress_alb.sg_id
}

resource "aws_security_group_rule" "bastion_ingress_alb_https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id        = module.sg_ingress_alb.sg_id
}


resource "aws_security_group_rule" "internet_ingress_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.sg_ingress_alb.sg_id

}



resource "aws_security_group_rule" "local_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["203.192.244.204/32"]
  security_group_id = module.sg_bastion.sg_id

}


resource "aws_security_group_rule" "bastion_sql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id        = module.sg_mysql.sg_id
}


resource "aws_security_group_rule" "eks_nodes_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.sg_eks_node.sg_id
  security_group_id        = module.sg_mysql.sg_id
}



resource "aws_security_group_rule" "bastion_eks_control_plane" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id        = module.sg_eks_control.sg_id
}

resource "aws_security_group_rule" "ingress_alb_eks_nodes" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.sg_ingress_alb.sg_id
  security_group_id        = module.sg_eks_node.sg_id
}


















