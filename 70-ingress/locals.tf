locals {
  public_subnet_ids           = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  alb_ingress_sg_id           = data.aws_ssm_parameter.sg_ingress_alb_id.value
  ingress_alb_certificate_arn = data.aws_ssm_parameter.cert_arn.value
  resource_name               = "${var.project_name}-${var.environment}"
  vpc_id                      = data.aws_ssm_parameter.vpc_id.value
  zone_id                     = data.aws_route53_zone.cert.zone_id
}