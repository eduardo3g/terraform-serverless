module "users" {
  source         = "../../infra/users"
  environment    = "${var.environment}"
  write_capacity = 1
  read_capacity  = 1
  jwt_secret = "${var.jwt_secret}"
}

module "bookings" {
  source         = "../../infra/bookings"
  environment    = "${var.environment}"
  write_capacity = 1
  read_capacity  = 1
}