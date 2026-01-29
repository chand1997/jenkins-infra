data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/expense/dev/public_subnet_ids"
}

data "aws_ssm_parameter" "sg_bastion_id" {
  name = "/expense/dev/sg_bastion_id"
}