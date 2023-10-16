#this needs packer init . command
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.5"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

packer {
  required_plugins {
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

locals {
  shared_dir = "${path.root}/../../ansible-roles"
}

source "amazon-ebs" "debian" {
  ami_name      = "${var.project_name}-os-ami"
  instance_type = "t4g.micro"
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "debian-12-arm64-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["136693071363"]
  }
  ssh_username = "admin"
}

build {
  name = "debian-packer"
  sources = [
    "source.amazon-ebs.debian"
  ]

  ## start actual instance configuration via ansible
  provisioner "ansible" {
    ansible_env_vars = [ "ANSIBLE_ROLES_PATH=~/ansible-roles" ]
    playbook_file = "${path.root}/ansible/playbook.yml"
    extra_arguments = [
      "--extra-vars", "aqv_environment=test",
      "--extra-vars", "application=opencart"
    ]
  }
}

