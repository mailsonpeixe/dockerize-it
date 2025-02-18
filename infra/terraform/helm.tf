resource "helm_release" "metallb" {
  name = "metallb"
  chart = "metallb"
  namespace = "metallb-system"
  repository = "https://metallb.github.io/metallb"
  create_namespace = true
  version = "0.14.9"
}

resource "helm_release" "ingress_controller_default" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-controller"
  version          = "4.12.0"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  create_namespace = true
}

resource "helm_release" "argo_cd" {
  name             = "argo-cd"
  chart            = "argo-cd"
  namespace        = "gitops"
  version          = "7.8.2"
  repository       = "https://argoproj.github.io/argo-helm"
  create_namespace = true
  values = [
    yamlencode({
      global = {
        domain = "argocd.dockerizeit.local"
      }
      configs = {
        params = {
          "server.insecure" = true
        }
      }
      server = {
        ingress = {
          enabled          = true
          ingressClassName = "nginx"
        }
      }
    })
  ]
}

resource "helm_release" "argo_apps" {
  name             = "argocd-apps"
  chart            = "argocd-apps"
  namespace        = "gitops"
  version          = "2.0.2"
  repository       = "https://argoproj.github.io/argo-helm"
  create_namespace = true
  values = [
    yamlencode({
      applications = merge(
        {
          for application in var.applications : application.name => {
            name    = application.name
            project = application.project
            ignoreDifferences = [{
              group = "apps"
              kind  = "Deployment"
              jsonPointers = [
                "/spec/replicas",
                "/spec/template/metadata/annotations/rollme"
              ]
            }]
            source = {
              repoURL        = "${var.source_repo}/${application.repo_url}"
              targetRevision = "${application.project == "infra"}" ? "main" : var.branch_to_deploy[var.environment]
              path           = application.charts_path
              helm = "${application.project == "infra"}" ? null : {
                valueFiles = ["envs/${var.environment}/values.yaml"]
                parameters = [
                  {
                    name  = "deployment.tag"
                    value = "$ARGOCD_APP_REVISION"
                  }
                ]
              }
            }
            destination = {
              server    = "https://kubernetes.default.svc"
              namespace = "default"
            }
            syncPolicy = "${application.project == "infra"}" ? {
              automated = {
                prune    = true
                selfHeal = false
              }
            } : null
          }
        }
      )
    })
  ]
  depends_on = [
    helm_release.argo_cd
  ]
}
