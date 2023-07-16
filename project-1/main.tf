resource "kubernetes_deployment" "node-todo" {
  metadata {
    name = "node-todo"
    labels = {
      app = "node-todo"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "node-todo"
      }
    }

    template {
      metadata {
        labels = {
          app = "node-todo"
        }
      }

      spec {
        container {
          image = "amofidian69/node-todo:v1"
          name  = "node-todo"

          port {
            container_port = 8000
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "node-todo-svc" {
  metadata {
    name = "node-todo-svc"
  }

  spec {
    selector = {
      app = "node-todo"
    }

    port {
      port        = 80
      target_port = 8000
      node_port   = 30007
    }

    type = "NodePort"
  }
}