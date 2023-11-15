locals {
  namespace = terraform.workspace
  environment = terraform.workspace

  install_plan = tomap({
    "dev"  = "small",
    "uat"  = "medium",
    "prod" = "small"
  })[terraform.workspace]
}