resource "aws_dynamodb_table" "hello_world" {
  name = "${var.environment}_hello-world"
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }

  write_capacity = "${var.write_capacity}"
  read_capacity = "${var.read_capacity}"
}