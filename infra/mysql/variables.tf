variable "vpc_id" {
    type = string
    description = "vpc id to buil mysql rds resources"
    default = ""
}

variable "project_name" {
  type = string
}

variable "application_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "cost_center" {
  type = string
}
 
variable "additonal_sg_cidrs" {
    type = list(string)
    description = "additional cidrs allowed to access rds cluster"
    default = []
}
 
# rds vars
variable "rds_engine" {
    description = "rds engine typw"
    type = string
}

variable "rds_engine_major_version" {
  description = "major engine version of rds cluster"
  type = string
}

variable "rds_engine_minor_version" {
  description = "minor engine version of rds cluster"
  type = string
}

variable "rds_engine_family_version" {
  description = "engine family version of rds cluster"
  type = string
}

variable "rds_instance_type" {
  description = "instance types for rds cluster"
  type = string
}

# db vars
variable "db_name" {
    description = "Name of databse to be created with RDS cluster."
  type = string
}

variable "db_user_name" {
    description = "User created with database. Will have full admin right s to database."
  type = string
}

variable "db_user_password" {
    description = "Password for user created with database. Will have full admin right s to database."
  type = string
}




