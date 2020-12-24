module "hello" {
  source         = "../../infra/hello"
  environment    = "${var.environment}"
  write_capacity = 1
  read_capacity  = 1
}