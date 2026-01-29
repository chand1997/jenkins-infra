resource "aws_ssm_parameter" "cert_arn" {
  name  = "/${var.project}/${var.environment}/cert_arn"
  type  = "String"
  value = aws_acm_certificate.cert.arn
}