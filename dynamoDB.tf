resource "aws_dynamodb_table" "rds_data" {
  name  = "rds_data_table"
  billing_mode = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1
  range_key = "DB_endpoint"
  hash_key = "DB_type"

  attribute {
      name = "DB_endpoint"
      type = "S"
  }

  attribute {
      name = "DB_type"
      type = "S"
  }
}
