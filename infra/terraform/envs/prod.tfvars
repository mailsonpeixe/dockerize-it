environment = "prod"
source_repo = "git@github.com:almeida-silas"
applications = [
  {
    name        = "dockerize-it"
    project     = "backend"
    charts_path = "./backend/charts"
    repo_url    = "dockerize-it.git"
  },
  {
    name        = "configmap-and-secrets"
    project     = "infra"
    charts_path = "./infra/configmap-and-secrets"
    repo_url    = "dockerize-it.git"
  }
]
