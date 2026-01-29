locals {
  name                    = "${var.project_name}-${var.environment}"
  vpc_id                  = data.aws_ssm_parameter.vpc_id.value
  private_subnet_ids      = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  eks_control_plane_sg_id = data.aws_ssm_parameter.sg_eks_control_id.value
  eks_node_sg_id          = data.aws_ssm_parameter.sg_eks_node_id.value
}