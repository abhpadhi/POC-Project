variable  "rds_id"{
    type = string
    default = "admin"
}

variable "rds_pwd" {
  type = string
  default = "password"
}

variable "rds_instance_class" {
  type = string
  default = "db.t2.micro"
}



