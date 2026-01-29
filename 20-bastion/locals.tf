locals {
  sg_bastion_id = data.aws_ssm_parameter.sg_bastion_id.value
  subnet_id     = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]
}