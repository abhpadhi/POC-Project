#AWS RDS creation 

resource "aws_db_instance" "rds-1" {
    name = "Project-db-1"
    allocated_storage = 20 
    engine = "mysql"
    engine_version = "5.7"
    storage_type = "gp2"
    instance_class = var.rds_instance_class
    username = var.rds_id
    password = var.rds_pwd
    parameter_group_name = "default.mysql5.7"
    multi_az = "false"
    port = "3306"
}

resource "aws_db_instance" "rds-2" {
    name = "Project-db-2"
    allocated_storage = 20 
    engine = "mysql"
    engine_version = "5.7"
    storage_type = "gp2"
    instance_class = var.rds_instance_class
    username = var.rds_id
    password = var.rds_pwd
    parameter_group_name = "default.mysql5.7"
    multi_az = "false"
    port = "3306"
}

