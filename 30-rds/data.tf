data "aws_ssm_parameter" "sg_mysql_id" {
  name = "/expense/dev/sg_mysql_id"
}

data "aws_ssm_parameter" "database_subnet_group_name" {
  name = "/expense/dev/database_subnet_group_name"
}

data "aws_route53_zone" "cert" {
  name         = var.domain_name
  private_zone = false
}