resource "aws_dynamodb_table" "users" {
  name     = "${var.environment}-users"
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
  write_capacity = "${var.write_capacity}"
  read_capacity  = "${var.read_capacity}"
}

resource "aws_ssm_parameter" "dynamodb_users_table" {
  name  = "${var.environment}-dynamodb-users-table"
  type  = "String"
  value = "${aws_dynamodb_table.users.name}"
}