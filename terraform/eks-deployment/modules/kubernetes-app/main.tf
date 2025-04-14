 # Kubernetes deployment
resource "kubernetes_deployment" "app" {
  metadata {
    name = "dwom-app"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "dwom-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "dwom-app"
        }
      }

      spec {
        container {
          image = var.docker_image
          name  = "dwom-app"



          port {
            container_port = 8000
            protocol      = "TCP"
          }


          readiness_probe {
            http_get {
              path = "/"
              port = 8000
            }
            initial_delay_seconds = 30
            period_seconds       = 10
            timeout_seconds     = 5
            success_threshold   = 1
            failure_threshold   = 3
          }

          # Liveness probe - checks if the app is running
          liveness_probe {
            http_get {
              path = "/"
              port = 8000
            }
            initial_delay_seconds = 15
            period_seconds       = 20
            timeout_seconds     = 5
            success_threshold   = 1
            failure_threshold   = 3
          }

          # Startup probe - gives the app time to start up
          startup_probe {
            http_get {
              path = "/"
              port = 8000
            }
            initial_delay_seconds = 10
            period_seconds       = 5
            timeout_seconds     = 5
            success_threshold   = 1
            failure_threshold   = 30
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "dwom-app-lb"
    namespace = "default"
  }

  spec {
    selector = {
      app = "dwom-app"
    }

    port {
      port        = 80
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}
