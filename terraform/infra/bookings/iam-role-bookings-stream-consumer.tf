resource "aws_iam_role" "bookings_stream_consumer_iam_role" {
  name = "${var.environment}-bookings-stream-consumer-iam-role"

  assume_role_policy = templatefile("${path.module}/templates/lambda-base-policy.tpl", {})
}

resource "aws_ssm_parameter" "bookings_stream_consumer_iam_role" {
  name  = "${var.environment}-bookings-stream-consumer-iam-role"
  type  = "String"
  value = aws_iam_role.bookings_stream_consumer_iam_role.arn
}