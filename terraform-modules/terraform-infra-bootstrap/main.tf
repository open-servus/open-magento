resource "aws_ami_copy" "os_ami" {
  count             = var.region != var.central_aws_region ? 1 : 0
  name              = "${var.project_name}-os-ami"
  description       = "A copy of ${var.aws_amis.web}"
  source_ami_id     = var.aws_amis.web
  source_ami_region = var.central_aws_region

  tags = {
    Name = "OS-AMI"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-deployer-key"
  public_key = var.ssh_public_key
}