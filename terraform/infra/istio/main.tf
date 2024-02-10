locals {
  app_name      = "istio"
  app_team      = "devops"
  app_env       = "dev"
  istio_chart_version = "1.20.2"
  kiali_chart_version = "1.79.0"

  owner_labels = {
    "app.kubernetes.io/name" = local.app_name
    "inception.tivo.com/team" = local.app_team
    "inception.tivo.com/product" = local.app_name
    "inception.tivo.com/env" = local.app_env
  }
  owner_annotations = {
    "inception.tivo.com/email" = "something@gmail.com"
    "inception.tivo.com/slack" = "k8s-pd"
  }

  # kind/k8s settings
  host                   = "https://192.168.1.101:40447"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJME1ESXdOekU0TWpBeU5sb1hEVE0wTURJd05ERTRNakF5Tmxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT045Cmp5Z2Y5MUNHSmVZUTdrQXVGb0ZLNzFWU2UyLzhjUVZPcHhYWHpXcHk3VUZkd0JjTlZqWmNJRHRFY2VnbzYxNXAKSGZEbzUxcmRoZis0K2E2SzZ6bTJVd05Ta2JhdGUzYzUyazkzcmNGenYxUW9RYS9kU01qUGR4OGJ2eUhZNXRjMApncUdsT2tGWWxEVnB5bHhFc2p3dUw0RldTd2RQWU5ZelBxWERHNk9rcHFnUldUWWFuRkxQemdKenRFSnZXMW9wCllLK2h2K1V0RFBncFVmRitmdXZBUEM5YTl6T1dJbVl4VEdTRlJzdE9QTmQ1UGlhaVA5dS9pM2p3cUFLWlpOMmgKbDlLUWFDbmpKWmpRMndJQ09ibXJiV0pqNm1xUjlLQ2l2em4xai9PMHg3bmNSay9oRXppUk5MVUxWbEhwWmtIZApsZ1Q0SlBJd0hKNUpIVGlwV3ZVQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZEdDhZYnBhbUVHb3BYVWdidk9pbW5UUlpyUURNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBRzNZV2hFTm03T1RxZmxUbDU2bApDeDhWM2N3YjBFV3BhRlF3elQzb1JyZWE5Uys5WG5DSk5DVUlKeW9nK1N6MW01QVVnR0h6QXRPcFFCQ1Q3TmF2CnUyN1JWbkplOS9rRWNzU3IzbnhGamRFcFkxbXlsK0p3Z0lyZjk2Qm9BNzlyc0JsallOYXhXSVhkUHQ3engwWUcKUlFqNGYxZXBJV0dUeHAwVWpJWEFyRjZDTk5CTHZTM2M4NmRPL0NNTlFnaktMVWdpTm1iZjJYTjRiZ1oyS3JWNQo5V2I2MGlVcGN5WEFSMUlQdEtiMlA5WE9Rc1BURHpoWlV1Q0xPZmViRU5Tb2Y1ODBYWmpQem5MbkYxaHVSN1dJCk5EMmdaWFhFSkF5UDlPWjFXVEh6cE1HSU1mRWpSSE5aVlB2d3ZSa2N3WFdpOFpGejZaei9QUGlrUC91a1BiaXcKNUNjPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==")
  client_key             = base64decode("LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcFFJQkFBS0NBUUVBdm5FMUw4RVZ6MXg0ZDJXY0U3bXdwNGhvNHRFRWY3VXd1MnBTU2l5cnZCNkZlV1RkCnNHdVoxeitkWVJSc2xtZW5PaDVsTmtRK2JHcmY4RUhQT2dVV2pVMUVGRXVhRUppL01tcitxVmVYT3Jtc0xGU0sKZi9nejdoRE5YcWp1UjdlUmhqbGxmamRDY2ROb0NDMjRxSWJQQURCQTN5QjFucnFzc0p2WjJpcllRb0N1bEhiagovUUZiNGJOai9iek5jN3l1a0Z1Tkc4MXhUQVRTYXZ5dUo1bzZGV2s1NzEwZUhqMHBqaDV5bVNCWWZESFMwR2VZCkpUTEQ3NEZvSjZWdE94U1JXd0ZkS0Z6NG1wRkdCb01IcXJjNlJWZ3dSZVhYUkV5ZndmakNYTzc2dnluREF1STkKQ0gwd1N1ZXVwdVpSeCtFdkJNQk9UanJWaVFNenFSZzlPOW9EbFFJREFRQUJBb0lCQVFDUjlNbkNrOFZYYTVPWQpUblBVV2xpZHpkbzFHK1RLeTk5UmhDY1ZXaTgwdWwrcHJqaUo0YTNDWHFzTG9FK281a0F3TnVOek45SnYzV2xNCkJlUUFuNjJ0Rmk2N0wwWWd1akN2UDNsMTUvK3JybW5hZitDMk8wL3hnVWNrNld2VjQwYlJER1JRMjZFOUE3MlQKcHhjRGNtNXJ3bysxY25jeTgvY3VWQVFmUlA4QjE3TFZucGF1Q3NlTHQvbENjR2pXYXllODc5dnYvMENuTTg5cwpsTGVMU1BodEkzQWJlWG4razRiTXkrQzBlT0hPb3dVVmhhZi9pcXJoWnJ1QjFRR2xEOVlTUS9qRXpqclFCL0YwCi9PV21GR0FRNng0YzcrTkdrREZWQTlmdEpSMk9GQ1RWOHFGVEFGTjFrazBmT1ArazArb1pQVE1wNU4rK0tETjMKclBlbWxyNkJBb0dCQU05UjJPWDlSQWVNQllXUHZac2VJQWR5bGF4UWtseGVhVUgvNU1CbnZsNzJDMXZyazJtTwpRZ2ZWSnZ1MS9GT0J1T2REeWorU2VIeTl6VENvT3liUmUzcFp4WXR6b3dhOGJheHVRRWlFVDNUNlBrYlRLakhZClZHUkcxaUVUQ2tESTd2eXRqT2h1R2hkNUk0ZFcrNzVHbFNlc0lXSUlVNmlMV0dCbEVNRGU5Yng1QW9HQkFPc28KMXplUm1mTW9SNW8rUGU1ajhhMFcxK3FLSTV6cTVOSmVUMkY4bERlbUJoTUcwVWdrMXVCbW5CbzU5Z1BCOUl4cgpyUFJuMGRxQ3NZVmt5WHcwRGRuUUI0TE4zbURkRmRUR0Nic296UHM3R2YrV2xXWWw5cG9YVUhuR0JsbnNNTVV1ClZlem9BelJGWkh2ZXJRaVVHSmtCY3d4SkN0MTNTKytMRGpKUnhNRDlBb0dCQU1jejBwL3lRWHFxN09kUG5SUzkKMW5LeGcrVWxLZXk4L3BCZkMzSmdmSWdNREJBUGcvNEpwYUtYQ2JVVVFOWVFNQlZ1aXBlWTZsS1pvTjRlMTI5TwpHMElObmdXSFg5N3FFTXQ4eUNHbG1COUREN0hIMXFROFE2SnllZThmdDF0V2RtT3RjbFltN01VZkxhY3VTZ2VqCkZGQWhVWlk3Zi83VG5XQkoyOVltcGFHcEFvR0FPOUtIN1hyOHp2N1FPRXpkTkdmNGN5LzhmWTNtd1dTQUVZUXMKYllCanRFUm9CeThVem1XUXhFVldNTlhOMytiWGIyRjAvamZyQ3N0MG5acW1KeEtXODNJWWR3NG9KRHdaOGFidgprczB1V0RzUXdoUnNyUys3TERnQ0lQaGZaVURRcDFqQ1F5SkNybWw0eG9vL09vOXlNbnBMNmpRcXIyeEp4UVo2CjloSVhHNEVDZ1lFQWtWQng4Vncvd0VOTE05R04ySFJ0TkhwUnQ2RE9FcWhNNEFwK0w3WEVwNTNQMW4wOXVPbFkKM1VJNEl4MUVlOTE1UkxMcFZqa3NJLy9wTkdGeG1QWnFEL3ladWI4RlNpMHhCVGlDa0pQODZBN2NDeFNSMjViYwptRk1WQWpvTk9GU3FCM0Q3UUZtQ2FpdlZveWZab0JGa2Q5NXpFc0xGZU9LMWlHTTJadk1rV09jPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=")
  client_certificate     = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lJQzhtK09rYWJXakF3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBeU1EY3hPREl3TWpaYUZ3MHlOVEF5TURZeE9ESXdNamRhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQXZuRTFMOEVWejF4NGQyV2MKRTdtd3A0aG80dEVFZjdVd3UycFNTaXlydkI2RmVXVGRzR3VaMXorZFlSUnNsbWVuT2g1bE5rUStiR3JmOEVIUApPZ1VXalUxRUZFdWFFSmkvTW1yK3FWZVhPcm1zTEZTS2YvZ3o3aEROWHFqdVI3ZVJoamxsZmpkQ2NkTm9DQzI0CnFJYlBBREJBM3lCMW5ycXNzSnZaMmlyWVFvQ3VsSGJqL1FGYjRiTmovYnpOYzd5dWtGdU5HODF4VEFUU2F2eXUKSjVvNkZXazU3MTBlSGowcGpoNXltU0JZZkRIUzBHZVlKVExENzRGb0o2VnRPeFNSV3dGZEtGejRtcEZHQm9NSApxcmM2UlZnd1JlWFhSRXlmd2ZqQ1hPNzZ2eW5EQXVJOUNIMHdTdWV1cHVaUngrRXZCTUJPVGpyVmlRTXpxUmc5Ck85b0RsUUlEQVFBQm8xWXdWREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RBWURWUjBUQVFIL0JBSXdBREFmQmdOVkhTTUVHREFXZ0JRN2ZHRzZXcGhCcUtWMUlHN3pvcHAwMFdhMApBekFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBNGx3bWdUa0VVQkIxUmRqRk8yKzdEVm11OTl4MW5SckRFRis1CmdXRHRRZnBuOTJ3bm9yLzVMdTJ3VlQrWEhXWUljR0ZwZU1MUk1tMzJoUnRaRG1RZUMxb2ZGemhHZTlCbWpIVDUKY1U0Si9IeDBtVzBZbFJjZkphM0lzYkdwMmNWWER5dXhKTTdlSWxER1ZRQ241SEFRTmliNXhucVg4S1p3bHQ3SgplUy9XTmN5dTZlZmptMnlNQ1ZnN01CNmp2TWRmZzRDN3l0NVZyVkQ1ckgyTlZDT1NVWVgwZUJ4b0ZXWVh3TE1wCllsb3hNNG1GSUxoM1Zpb3dhUWlJNjNySnJhZ0xwSU02N2N1Rkk3UzN1TktvditHaTVhazY1VnAxM2s4M2w2SnEKUVlIRjFJL0l2K2dpZncxQ1lJWDlOOGhiODZnMnRQbU1XVWNiN2N2NUJCRms5NTBEcFE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==")
  
}

provider "kubernetes" {
  host                   = local.host
  cluster_ca_certificate = local.cluster_ca_certificate
  client_key             = local.client_key
  client_certificate     = local.client_certificate
}

provider "helm" {
  kubernetes {
    host                   = local.host
    cluster_ca_certificate = local.cluster_ca_certificate
    client_key             = local.client_key
    client_certificate     = local.client_certificate
  }
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = "istio-system"
  }
}

resource "helm_release" "istio-base" {
  name = "istio-base"
  namespace = kubernetes_namespace.this.metadata.0.name
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "base"
  version = local.istio_chart_version

  values = [ templatefile("${path.module}/istio-base-values.yaml.tpl",
    {
      annotations = indent(6, "      ${yamlencode(local.owner_annotations)}")
      labels = indent(6, "      ${yamlencode(local.owner_labels)}")
    })
  ]
}

resource "helm_release" "istiod" {
  name = "istiod"
  namespace = kubernetes_namespace.this.metadata.0.name
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istiod"
  version = local.istio_chart_version

  values = [ templatefile("${path.module}/istiod-values.yaml.tpl",
    {
      annotations = indent(4, "    ${yamlencode(local.owner_annotations)}")
      labels      = indent(4, "    ${yamlencode(local.owner_labels)}")
    })
  ]

  depends_on = [ helm_release.istio-base ]
}

#resource "helm_release" "ingress-gateway" {
#  name = "ingress-gateway"
#  namespace = kubernetes_namespace.this.metadata.0.name
#  repository = "https://istio-release.storage.googleapis.com/charts"
#  chart = "gateway"
#  version = local.istio_chart_version
#
#  values = [ templatefile("${path.module}/ingress-gateway-values.yaml.tpl",
#    {
#      annotations = indent(2, "  ${yamlencode(local.owner_annotations)}")
#      labels      = indent(2, "  ${yamlencode(local.owner_labels)}")
#    })
#  ]
#
#  depends_on = [ helm_release.istiod ]
#}

resource "helm_release" "kiali" {
  name = "kiali"
  namespace = kubernetes_namespace.this.metadata.0.name
  repository = "https://kiali.org/helm-charts"
  chart = "kiali-server"
  version = local.kiali_chart_version

  values = [ templatefile("${path.module}/kiali-values.yaml.tpl",
    {
      namespace     = kubernetes_namespace.this.metadata.0.name
      auth_strategy = "anonymous"
      annotations   = indent(4, "    ${yamlencode(local.owner_annotations)}")
      labels        = indent(4, "    ${yamlencode(local.owner_labels)}")
    })
  ]

  depends_on = [ helm_release.istiod ]
}
