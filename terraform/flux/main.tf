locals {
  github_org        = "mpeters0n"
  github_token      = "b6f4ed3548902c59c3408d0f110ab0241e339f4d"
  github_repository = "flagger-poc"
}

provider "github" {
  owner = local.github_org
  token = local.github_token
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

provider "kind" {}

resource "kind_cluster" "this" {
  name = "kind-kind"
}

provider "flux" {
  kubernetes = {
    host                   = kind_cluster.this.endpoint
    client_certificate     = kind_cluster.this.client_certificate
    client_key             = kind_cluster.this.client_key
    cluster_ca_certificate = kind_cluster.this.cluster_ca_certificate
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

  path = "terraform/flux"
}
