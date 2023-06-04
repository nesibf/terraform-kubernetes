// Create namespace for Operator
resource "kubernetes_namespace" "edu" {
  metadata {
    name = "edu"
  }
}

// Create terraformrc secret for Operator
resource "kubernetes_secret" "terraformrc" {
  metadata {
    name      = "terraformrc"
    namespace = kubernetes_namespace.edu.metadata[0].name
  }

  data = {
    "credentials" = file("${path.cwd}/credentials")
  }
}

// Create workspace secret for Operator
resource "kubernetes_secret" "workspacesecrets" {
  metadata {
    name      = "workspacesecrets"
    namespace = kubernetes_namespace.edu.metadata[0].name
  }

  data = {
    "AWS_ACCESS_KEY_ID"     = var.aws_access_key_id
    "AWS_SECRET_ACCESS_KEY" = var.aws_secret_access_key
  }
}

// Terraform Cloud Operator for Kubernetes helm chart
resource "helm_release" "operator" {
  name       = "terraform-operator"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "terraform"

  namespace = kubernetes_namespace.edu.metadata[0].name

  depends_on = [
    kubernetes_secret.terraformrc,
    kubernetes_secret.workspacesecrets
  ]
}
