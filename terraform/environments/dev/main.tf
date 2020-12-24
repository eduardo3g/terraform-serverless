module "users" {
  source         = "../../infra/users"
  environment    = "${var.environment}"
  write_capacity = 1
  read_capacity  = 1
}