#AWS RDS resource creation 

resource "aws_db_instance" "rds-1" {
    name = "Projectdb1"
    allocated_storage = 20 
    identifier = "db1"
    engine = "mysql"
    engine_version = "5.7"
    storage_type = "gp2"
    instance_class = var.rds_instance_class
    username = var.rds_id
    password = var.rds_pwd
    parameter_group_name = "default.mysql5.7"
    multi_az = "false"
    port = "3306"
    #snapshot_identifier = "snap1"
    skip_final_snapshot = "true"
}

resource "aws_db_instance" "rds-2" {
    name = "Projectdb2"
    allocated_storage = 20 
    identifier = "db2"
    engine = "mysql"
    engine_version = "5.7"
    storage_type = "gp2"
    instance_class = var.rds_instance_class
    username = var.rds_id
    password = var.rds_pwd
    parameter_group_name = "default.mysql5.7"
    multi_az = "false"
    port = "3306"
    #snapshot_identifier = "snap2"
    skip_final_snapshot = "true"
}

