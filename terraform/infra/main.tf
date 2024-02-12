locals {
  github_org        = "mpeters0n"
  # Must have ability to add ssh key
  # Needs to be a secret
#  github_token      = ""
  github_repository = "flagger-poc"
}

provider "github" {
  owner = local.github_org
  token = var.github_token
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = local.github_repository
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

provider "kubernetes" {
  config_path = "/home/mpeterson/kind.kubeconfig"
}

provider "flux" {
  kubernetes = {
    config_path = "/home/mpeterson/kind.kubeconfig"
  }
  git = {
    url = "ssh://git@github.com/${local.github_org}/${local.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  path = "terraform/flux-live"
}
