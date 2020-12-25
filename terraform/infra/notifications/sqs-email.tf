resource "aws_sqs_queue" "email" {
  name           = "${var.environment}-email-queue"
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.email_dlq.arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue" "email_dlq" {
  name = "${var.environment}-email-queue-dlq"
}