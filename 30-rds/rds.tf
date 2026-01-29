module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.13.1"

  identifier = "expense-dev"

  engine            = "mysql"
  engine_version    = "8.0.40"
  instance_class    = "db.t4g.micro"
  allocated_storage = 5

  db_name                     = "transactions"
  username                    = "root"
  port                        = "3306"
  password                    = "ExpenseApp1"
  manage_master_user_password = false
  skip_final_snapshot         = true

  vpc_security_group_ids = [local.sg_mysql_id]


  tags = {
    Name = "expense-dev"
  }

  # DB subnet group
  create_db_subnet_group = false
  db_subnet_group_name   = local.db_subnet_group_name

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}



resource "aws_route53_record" "rds_record" {
  zone_id = local.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "CNAME"
  ttl     = "30"
  records = [module.db.db_instance_address]
}

# Note:

# root--> chandev.site  subdomain(eg)--> yo.chandev.site

# A → root or subdomain, points to any IPv4 address (external or internal). ✅

# A Alias (Route 53) → root or subdomain, points only to supported AWS resources 
# (ALB, NLB, CloudFront,S3, etc.). ✅

# CNAME → subdomain only, points to any DNS name (external or internal), cannot be used at root. ✅



