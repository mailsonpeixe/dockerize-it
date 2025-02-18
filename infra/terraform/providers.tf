terraform {
  required_version = "> 1.0.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.35.1"
    }
  }
  cloud {
    organization = "Dockerize-it"
    workspaces {
      tags = ["main"]
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.kube_server
    cluster_ca_certificate = base64decode(var.kube_certificate_authority_data)
    client_certificate     = base64decode(var.kube_client_certificate_data)
    client_key             = base64decode(var.kube_client_key_data)
  }
}

provider "kubernetes" {
  host                   = var.kube_server
  cluster_ca_certificate = base64decode(var.kube_certificate_authority_data)
  client_certificate     = base64decode(var.kube_client_certificate_data)
  client_key             = base64decode(var.kube_client_key_data)
}
