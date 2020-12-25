resource "aws_ssm_parameter" "email_from" {
  name  = "${var.environment}-email-from"
  type  = "String"
  value = var.email_from
}

resource "aws_ssm_parameter" "email_from_password" {
  name  = "${var.environment}-email-from-password"
  type  = "String"
  value = var.email_from_password
}

resource "aws_ssm_parameter" "email_to" {
  name  = "${var.environment}-email-to"
  type  = "String"
  value = var.email_to
}

resource "aws_ssm_parameter" "smtp_server" {
  name  = "${var.environment}-smtp-server"
  type  = "String"
  value = var.smtp_server
}