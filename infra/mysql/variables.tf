variable "project_name" {
  type        = string
  description = "vpc id to buil mysql rds resources"
  default     = "bookstore"
}
variable "tags" {
  type = map(string)
  description = "tags to be applied to resources"
  default = {
    Owner = "Sam Thompson"
    Enviroment = "dev"
    "Cost Center" = "1000"
  }
}

