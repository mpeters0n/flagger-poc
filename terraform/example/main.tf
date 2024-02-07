locals {
  app_name = "example"
  app_team = "devops"
  env      = "dev"
}

provider "kubernetes" {
  config_path    = "/home/mpeterson/kind.kubeconfig"
  config_context = "kind"
  host = "https://127.0.0.1:45351"
  cluster_ca_certificate = "/home/mpeterson/kind_ca.pem"
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = "example"
  }
}

resource "kubernetes_deployment" "this" {
  metadata {
    name      = local.app_name
    namespace = kubernetes_namespace.this.metadata.0.name
#    namespace = "flux-system"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = local.app_name
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = local.app_name
        }
      }
      spec {
        container {
          image = "nginx:1.21.6"
          name  = "example"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
