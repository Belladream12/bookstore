

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}


# bring your own vpc. 
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}*"]
  }
}

# bring your own subnets. 
data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-private*"]
  }
}

data "aws_subnet" "private_subnet_list" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
}


data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-public*"]
  }
}

data "aws_subnet" "public_subnet_list" {
  for_each = toset(data.aws_subnets.public_subnets.ids)
  id       = each.value
}

locals {
  db_name = "${var.project_name}-${var.application_name}-db-${var.environment}-${random_id.random.hex}"

  tags = {
    Environment   = var.environment
    Project       = var.project_name
    Owner         = var.owner
    "Cost Center" = var.cost_center
  }

}


