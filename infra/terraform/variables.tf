variable "environment" {
  type = string
}
variable "kube_server" {
  type = string
}
variable "kube_client_key_data" {
  type = string
}
variable "kube_client_certificate_data" {
  type = string
}
variable "kube_certificate_authority_data" {
  type = string
}
variable "ssh_private_key" {
  type = string
}
variable "dockerhub_username" {
  type = string
}
variable "dockerhub_password" {
  type = string
}
variable "source_repo" {
  type = string
}
variable "branch_to_deploy" {
  type = map(string)
  default = {
    dev  = "develop"
    prod = "main"
  }
}
variable "applications" {
  type = list(object({
    name        = string
    project     = string
    repo_url    = string
    charts_path = string
  }))
}
