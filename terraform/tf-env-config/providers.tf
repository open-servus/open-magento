terraform {
  required_providers {
    ansiblevault = {
      source  = "MeilleursAgents/ansiblevault"
      version = ">= 2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }

    local = {
      source = "hashicorp/local"
    }

    null = {
      source = "hashicorp/null"
    }

  }
}