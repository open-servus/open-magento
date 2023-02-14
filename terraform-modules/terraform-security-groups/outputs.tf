output "sg_admin" {
  value       = aws_security_group.admin.id
  description = "Admin SG"
}

output "sg_whitelist" {
  value       = aws_security_group.whitelist.id
  description = "Whitelist SG"
}

output "sg_alb" {
  value       = aws_security_group.alb_sg.id
  description = "Alb SG"
}