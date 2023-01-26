terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">=1.13.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = pathexpand("~/.kube/config")
  }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
}