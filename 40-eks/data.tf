data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}


data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "sg_eks_control_id" {
  name = "/${var.project_name}/${var.environment}/sg_eks_control_id"
}

data "aws_ssm_parameter" "sg_eks_node_id" {
  name = "/${var.project_name}/${var.environment}/sg_eks_node_id"
}