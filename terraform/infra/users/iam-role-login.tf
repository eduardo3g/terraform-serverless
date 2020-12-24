resource "aws_iam_role" "login_iam_role" {
  name = "${var.environment}-login-iam-role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_ssm_parameter" "login_iam_role" {
  name  = "${var.environment}-login-iam-role"
  type  = "String"
  value = "${aws_iam_role.login_iam_role.arn}"
}