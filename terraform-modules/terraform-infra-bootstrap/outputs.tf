output "os_ami" {
  value       = join("", aws_ami_copy.os_ami[*].id)
  description = "AMI copied"
}

output "aws_key_pair" {
  value       = aws_key_pair.deployer.id
  description = "aws_key_pair"
}