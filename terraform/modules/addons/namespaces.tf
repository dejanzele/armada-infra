resource "kubernetes_namespace" "armada" {
  metadata {
    name = "armada"
  }
}

resource "kubernetes_namespace" "gr_system" {
  metadata {
    name = "gr-system"
  }
}