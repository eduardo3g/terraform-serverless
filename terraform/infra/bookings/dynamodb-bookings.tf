resource "aws_dynamodb_table" "bookings" {
  name     = "${var.environment}-bookings"
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
  write_capacity = "${var.write_capacity}"
  read_capacity  = "${var.read_capacity}"
}

resource "aws_ssm_parameter" "dynamodb_bookings_table" {
    name  = "${var.environment}-dynamodb-bookings-table"
    type  = "String"
    value = "${aws_dynamodb_table.bookings.name}"
}