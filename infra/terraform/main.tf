resource "kubernetes_namespace_v1" "gitops" {
  metadata {
    name = "gitops"
  }
}

resource "kubernetes_namespace_v1" "applications" {
  metadata {
    name = "applications"
  }
}

resource "kubernetes_secret_v1" "git_private_key" {
  metadata {
    name      = "git-secret"
    namespace = "gitops"
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }
  data = {
    type          = "git"
    url           = var.source_repo
    sshPrivateKey = base64decode(var.ssh_private_key)
  }
  depends_on = [
    kubernetes_namespace_v1.gitops
  ]
}

resource "kubernetes_secret_v1" "dockerhub_credentials" {
  metadata {
    name      = "dockerhub-secret"
    namespace = "applications"
  }
  data = {
    docker-server   = base64encode("https://index.docker.io/v1/")
    docker-username = base64encode(var.dockerhub_username)
    docker-password = base64encode(var.dockerhub_password)
  }
  depends_on = [
    kubernetes_namespace_v1.applications
  ]
}
