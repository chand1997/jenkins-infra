resource "aws_ssm_parameter" "sg_mysql_id" {
  name  = "/${var.project_name}/${var.environment}/sg_mysql_id"
  type  = "String"
  value = module.sg_mysql.sg_id
}


resource "aws_ssm_parameter" "sg_bastion_id" {
  name  = "/${var.project_name}/${var.environment}/sg_bastion_id"
  type  = "String"
  value = module.sg_bastion.sg_id
}

resource "aws_ssm_parameter" "sg_ingress_alb_id" {
  name  = "/${var.project_name}/${var.environment}/sg_ingress_alb_id"
  type  = "String"
  value = module.sg_ingress_alb.sg_id
}

resource "aws_ssm_parameter" "sg_eks_control_id" {
  name  = "/${var.project_name}/${var.environment}/sg_eks_control_id"
  type  = "String"
  value = module.sg_eks_control.sg_id
}

resource "aws_ssm_parameter" "sg_eks_node_id" {
  name  = "/${var.project_name}/${var.environment}/sg_eks_node_id"
  type  = "String"
  value = module.sg_eks_node.sg_id
}

