module "hello" {
  source         = "../../infra/hello"
  environment    = "${var.environment}"
  write_capacity = 10
  read_capacity  = 10
}