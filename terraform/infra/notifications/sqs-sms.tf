resource "aws_sqs_queue" "sms" {
  name           = "${var.environment}-sms-queue"
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sms_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "sms_dlq" {
  name = "${var.environment}-sms-queue-dlq"
}