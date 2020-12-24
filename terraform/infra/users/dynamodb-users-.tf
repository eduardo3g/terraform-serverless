resource "aws_dynamodb_table" "users" {
  name     = "${var.environment}-users"
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
  write_capacity = "${var.write_capacity}"
  read_capacity  = "${var.read_capacity}"

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name            = "${var.environment}-email-gsi"
    projection_type = "ALL"
    hash_key        = "email"
    write_capacity  = "${var.write_capacity}"
    read_capacity   = "${var.read_capacity}"
  }
}

resource "aws_ssm_parameter" "dynamodb_users_table" {
  name  = "${var.environment}-dynamodb-users-table"
  type  = "String"
  value = "${aws_dynamodb_table.users.name}"
}

resource "aws_ssm_parameter" "email-gsi" {
  name  = "${var.environment}-email-gsi"
  type  = "String"
  value = "${var.environment}-email-gsi"
}