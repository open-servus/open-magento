locals {
  namespace   = terraform.workspace
  environment = terraform.workspace

  install_plan = tomap({
    "dev"  = "small",
    "uat"  = "medium",
    "prod" = "large"
  })[terraform.workspace]

  aws_instance_type = tomap({
    "dev" = {
      general  = "t3.medium"
      admin    = "t3.medium"
      master   = "t4g.micro"
      nfs      = "t4g.micro" #"t3.small"
      varnish  = "t4g.micro"
      cloudlog = "t4g.micro"
    }
    "uat" = {
      general  = "t4g.medium"
      admin    = "t4g.medium"
      master   = "t4g.micro"
      nfs      = "t4g.micro" #"t3.small"
      varnish  = "t4g.micro"
      cloudlog = "t4g.micro"
    }
    "prod" = {
      general  = "m6g.large"
      admin    = "m6g.large"
      master   = "t4g.micro"
      nfs      = "t4g.micro" #"t3.small"
      varnish  = "t4g.micro"
      cloudlog = "t4g.micro"
    }
  })[terraform.workspace]
}