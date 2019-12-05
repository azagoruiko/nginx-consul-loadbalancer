job "nginx-job" {
  datacenters = ["home"]
  type        = "service"
  constraint {
    attribute = "${node.class}"
    value = "server"
  }

  group "nginx-group" {
    count = 1

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    task "nginx-task" {
      driver = "docker"
      
      config {
        image = "127.0.0.1:9999/docker/consul-template-nginx:0.0.3"

        port_map {
          web = 80
        }
      }

      resources {
        cpu    = 100
        memory = 512

        network {
          mbits = 10
          port  "web" {
            static = 80
          }
        }
      }

      service {
        name = "nginx-loadbalancer"
        port = "web"

        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}

