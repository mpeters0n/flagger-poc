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
  host                   = "https://192.168.1.101:42551"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJME1ESXhNakUzTVRReE0xb1hEVE0wTURJd09URTNNVFF4TTFvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTXFnCkpmaGFueFo4SzgvU3B6RE0xTFJQS0xndnFwdmFjOWRiQkdQVlZVVlFvcmRwOVFiMzRzTW4xNTZ3bFN3NXhibDEKd29hNkJmcURYd1Y3V0k5dmlDaTBCYjcrVFIrcncwcG0xWjVyaGxrMUdLWDBXblRZTDFFK1IwWEllUlcvNlh2TApaem1NVk5ZRW0rdU5OMlRpMlFZd1czQ0Y3RjJmYmUreGtVdlNGMkRxVEljeTFGWEVhOThkVitrZCtGN2VpNnFMClcvTm9zZkZsckNkTTVkQ0JFYUNiM1RVN3pQSnVRMi9na3IvT2YyUFJ2ZjZiN0xwNGZUS2Iyb1NnNGNuemRmYnAKWlI1elpjQWhPY2tZUUk3bzAvQkZWalVCSXJLRitLTmdhQy8yK1hqemJkaU5vVjdXSERnd1hVYmxSTjlDTHRNbgpvOG9udEdZZklvUHRRMEVqOEQwQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZCUis0WWJLUXhrZm9xZEVLekswUVE5RXRFUGtNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBSmxRUVgvai8wcHNZei93VFRnWgpLTkNMMXhZS29ld0ZCN2cyKzZYK29KeVdQRmFBYXFsSUdLd2NqdnBib2N6REJSVmtPcnRwZ2hJS3d0dnF6VldxCkRFalBNY0JObHI5RzRHRnpDek5YNFhqYlk4clVoR294OE9OQmY1eHlwd1Z2OWErMGYvSzBiUUdJbU8vOWJIM3IKN05rV3o0elZTc1g3T3A2blN1b01mdXFHQ3cxQzBFMnZiWEQyWW5vUVNubzFNVWlDMzVId2FSYmhCUmNheTc0WgpLcUFZNTNFelR5YWgwNUxubVRHZFpyRmNValBCdEo2Q05NL1FDMGl3Um5LOVlraUs3QnRKOUtuV1lOdnBVdkZ5Cmh4ODJXcGx4VVBVMXBhSmtyOW5zQU5ydmJ0bVd6TlMrbGg1dTZkQjZISC9NVGoxOStieThDYTRBNU96b0R3eWwKbHBFPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==")
  client_certificate     = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lJTXE4dWhGSlltajB3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBeU1USXhOekUwTVROYUZ3MHlOVEF5TVRFeE56RTBNVFZhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQTZwRG05N1RNRHJXTXdMNWgKcW5ieXJkMFk0WDN3d0pTeURKWTBwM3VyazhibHBqbGZZS2kvNWJxdFJraHVJTUJPdzNZbnRaNkp4OXQvVVVhUwpaS0JxVUpYUTVaems4NlZPekR2allEdEUyUGRvWDlxNEhBTkdSNXhObVdRRGc2VHdZcm4rODltUXN6c2dTVDNnCkV3ZHhoNGp4Mk9tM2NWOXFHOTlqSnREQVpJN29mMUtoNGpZczVGWWlRMDNtZEtkNnFxUGdib21xMUlZeXJGK2oKU2I3aHFTUWl4NzJwdVpyc1Q4Y0hWRDdtdzR2dytFTURudk5WRlpQQkVzb2FrRFNvbWVLejJ4THdlTURmUzVJeQpLTGU1Q3U1V2xxbGV1cVZHS094OFZ6d2hFLzV5OHhHNjc5ZDc3NTVnOXZrSnBYd1VDOCt5RlpabFFaWDNKUU1tCjNYUHNmd0lEQVFBQm8xWXdWREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RBWURWUjBUQVFIL0JBSXdBREFmQmdOVkhTTUVHREFXZ0JRVWZ1R0d5a01aSDZLblJDc3l0RUVQUkxSRAo1REFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBSnJHZ2NVNjRxa1VFMWpZR1JxZDQ4eDhsSjc1bHN5c3RLK2pQCmQxOGJoMnV5eWtlQ09RUGhjY1JWL3ZoTGIvYnFwbjJOL2Z6THZlUVhuSVV2c3JJMC9xd2NQZnpROXRzY1lENG0KTEJtZ2VweXJESFNOcXIvckFmL2ZLQ09JUllETkJGSXdvbVZnZzN5a0RPT1NLakU3RUQ4ejIrV3lEditMOTlHMQpQeVJtdS8wYjY4Z0piOFh2dDVGOVNJOUVJZytvZWI3MDdvRjhLdmQxeXk4aGJNUEN6WGhMTlY2NndzZU83Q29iCnJLTlpPN0xSSk5YU2dtMStiWTVLUU1obWVNNHZDMWtMdU9iOTNLeHJCYzJJcGNTSnd1b0tveERBUytWSTAxYlgKd1FmN0tJUmZsUVg5NFZsbkpTeFl5Q01Gcnh4WDZONmV4RXVNaWExS29DMjhFUnRqbUE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==")
  client_key             = base64decode("LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBNnBEbTk3VE1EcldNd0w1aHFuYnlyZDBZNFgzd3dKU3lESlkwcDN1cms4YmxwamxmCllLaS81YnF0UmtodUlNQk93M1ludFo2Sng5dC9VVWFTWktCcVVKWFE1WnprODZWT3pEdmpZRHRFMlBkb1g5cTQKSEFOR1I1eE5tV1FEZzZUd1lybis4OW1Rc3pzZ1NUM2dFd2R4aDRqeDJPbTNjVjlxRzk5akp0REFaSTdvZjFLaAo0allzNUZZaVEwM21kS2Q2cXFQZ2JvbXExSVl5ckYralNiN2hxU1FpeDcycHVacnNUOGNIVkQ3bXc0dncrRU1ECm52TlZGWlBCRXNvYWtEU29tZUt6MnhMd2VNRGZTNUl5S0xlNUN1NVdscWxldXFWR0tPeDhWendoRS81eTh4RzYKNzlkNzc1NWc5dmtKcFh3VUM4K3lGWlpsUVpYM0pRTW0zWFBzZndJREFRQUJBb0lCQUIvc0huTEJtUys3UjIrSAp1VlR3b1RCR01iZW1ZeGhpWkNUUVlGUVd3WS8zOXBMN3BkNUt1T3J6ejljTHpta0lvdTk0NmdpT2plTzBISXljCkZSbzZ0cDFHOWtuNVl6TkJZUXJzYjVKT0hwMkVkaUR0YkRicnZ5bkp2TW5PVWFnZHoxVXdTT0U0ejdlRXFXMHUKVFl0cGJPcnNHVFhUQU5NZUVCdkErQVoxVEdtaXdwQnJ1bVR5TUYreHhpVHlUNE51T2dRRnJBRXloT2s5elZKVQpHR1NYbnpGOFhvd1dvWXEwbDBaMlRGVkpMN1Z5RTFFOTVGQjFCT1BxaVhTUGUrQzNlNnZEYUxFYncvVisxU2MxCkx1Z0Q0QmRHb1VVV1RFTEVUR3g5WGlvUVBXdm5nQ1dJTVNxZUxhZ3ZzS0hPSnZjRDFvcDZaOUUzUmhKUzBNMGQKeFUzTW5sRUNnWUVBOWI2UWVNS1VtVmlOaERuZ1dWS0dVYW9nSGJ2TDQydk5ESWExYWhwZ2xoUUNQZS9EdzdNYQpZTndiTTkxdFFZZm0rZ0ZYWlNhQlRLZmw0WGdNQjQvUU5wZVV0VW1jT1d3U2d1Q3VYNFVES3BqbVNodHU5SG5NCldOOWlTZ05hdDRyc09vWlpVYUp1VEJKWUpWb1p1WUJ4T1VkU01oVWpDYlY1bVUzZElKM2R0a2NDZ1lFQTlGcnAKb2R0VW5YT3JTYWloRDBBYVNaS1FOMzVYL3UxV21LT0R2YStjcE5EOWYzUE1ZdlY2UW1iYWNma0hTb09id2djTAptMDJjZ01mdjZHblZyeHd4NnRjdzJSaWtBWTN2aHNEQ1MzR1l0akhHSWF3UVlsdXlkYkJiOEFwank0WEZ5Skd1CkI1TXRhMytNd3NLSld0aVZlUlU3ajY4d3drazhrVWNhQTd3aFhBa0NnWUVBb2lmdUV4RnFsc2w5RUV4VWd2eFcKajVxditJN01HalF2S04zVzViMmtFRVFCdXJiMHViVDhhZit6bjRTMExIS3Q4amhpWCtlSm1IaU4wenF3eldpVApYd0trNlA4NnJCVnBIWjErMHA3bG1QMHRzS2Jyanp5em44MC9nVkUzVWpmRWExWHRxRldEYklVS1R4Tm1PQ2JPCkQ1ckZYVERmWHUrMTNuZ251dmNRcnM4Q2dZQnpsMVlSNVFsZitrbTY3SFJVSElUUzdPd2Y5RHA0TTVuVlZ2U0oKRkx2TEU3bjNRcllhMGZqbDFIWGRtR29raTZGdzVaaE4vU2JkbkxjV2dJbys3ZDJITkFpOWlmUjdiOE14UVpvbgp5akx0YlJwRzczaElyd3Y2dEZTcGRxREN0Q05kdjl4TlpRZ0ZaQzhZS3FLRFFSVmtVL0Q3QldyUlhZZXpTYWs2CnZ4SWcwUUtCZ1FEQU1KSXZqTWFsQXF2OUk5ZTYvL1I0cmVSTlVCbmhTNHdzN1RyZW81SDlwK3FhdmdUWllEbTkKK2tuOS9JaHRGV2xrNE9yT1N2VjFVQUk0cGkrVlFtT29JWDk1V2czbjk0WE5jTmtxTTNWR0Z0UCtXNnliNmR4cgpIVnFKMzFvOHBnSUNGSDJoUzJDS3JMRDQ4MDIycExPbm5zRDR6OGFodFBwbWdnYjlhNW0yNXc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=")
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

resource "helm_release" "ingress-gateway" {
  name = "ingress-gateway"
  namespace = kubernetes_namespace.this.metadata.0.name
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "gateway"
  version = local.istio_chart_version

  values = [ templatefile("${path.module}/ingress-gateway-values.yaml.tpl",
    {
      annotations = indent(2, "  ${yamlencode(local.owner_annotations)}")
      labels      = indent(2, "  ${yamlencode(local.owner_labels)}")
    })
  ]

  depends_on = [ helm_release.istiod ]
}

# No terraform provider  for this:
resource "kubernetes_manifest" "istio_gateway" {
  manifest = yamldecode(templatefile("${path.module}/gateway.yaml", {
    namespace = kubernetes_namespace.this.metadata.0.name
  }))
}

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
