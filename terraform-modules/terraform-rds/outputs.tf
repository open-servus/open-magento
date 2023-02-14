output "project_db_endpoint" {
  value       = aws_db_instance.default.address
  description = "Project DB Endpoint"
}