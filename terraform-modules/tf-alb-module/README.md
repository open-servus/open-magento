# tf-alb-module
TF AWS Application Load Balancer

How to use it:

```
module "alb" {
  source               = "git::https://github.com/open-servus/tf-alb-module.git?ref=main"
  project_name         = "openservus"
  environment          = "prod"
  vpc_id               = "vpc-137958e3db27578aa"
  subnets              = ["subnet-0b9debbbda4659011","subnet-0286cd54d435aefa1"]
  web_instance_id      = "i-0f47b69c1eb927c75"
  alb_sg               = ["sg-07e9055bc23d4d8f8"]
  acm_arn              = "arn:aws:acm:us-east-1:059551436988:certificate/60555624-879e-4f39-ae6e-6er38dcbbee4"
}
```