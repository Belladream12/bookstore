provider "aws" {
  region = "us-east-1"
}

resource "random_id" "random" {
  byte_length = 2
}

resource "aws_security_group" "rds_sg" {
  name        = "rds sg"
  description = "rds sg"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "rds ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }

  ingress {
    description = "rds all ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [for s in data.aws_subnet.public_subnet_list: s.cidr_block]
  }

  ingress {
    description = "rds all ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.additonal_sg_cidrs
  }

  egress {
    description = "rds all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}


module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.0.3"

  identifier = local.db_name

  engine            = var.rds_engine
  major_engine_version = var.rds_engine_major_version
  engine_version    = var.rds_engine_minor_version
  instance_class    = var.rds_instance_type
  family = var.rds_engine_family_version
  
  allocated_storage = 30
  storage_encrypted = false

  # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  iam_database_authentication_enabled = false
  db_name     = var.db_name
  username = var.db_user_name
  password = var.db_user_password
  port     = "3306"

  create_db_subnet_group = true
  subnet_ids = [for s in data.aws_subnet.public_subnet_list: s.id]
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az = false

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  backup_retention_period = 0
  skip_final_snapshot = true
  deletion_protection = false

  enabled_cloudwatch_logs_exports = ["error", "general"]

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]

  # options = [
  #   {
  #     option_name = "Timezone"
  #     option_settings = [
  #       {
  #         name  = "TIME_ZONE"
  #         value = "UTC"
  #       },
  #     ]
  #   },
  # ]

  tags = local.tags
}
