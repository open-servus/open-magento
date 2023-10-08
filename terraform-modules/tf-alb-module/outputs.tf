output "lb_dns_name" {
  value = concat(aws_lb.main.*.dns_name, [""])[0]
}
output "web_tg_arn" {
  value = aws_lb_target_group.web.arn
}
output "alb_arn" {
  value = aws_lb.main.arn
}