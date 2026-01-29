locals {
  sg_mysql_id          = data.aws_ssm_parameter.sg_mysql_id.value
  db_subnet_group_name = data.aws_ssm_parameter.database_subnet_group_name.value
  zone_id              = data.aws_route53_zone.cert.zone_id
}
