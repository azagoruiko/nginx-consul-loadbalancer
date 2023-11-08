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

    network {
      port "web" {
        static = 80
      }
    }

    task "nginx-task" {
      driver = "docker"
      
      config {
        image = "10.8.0.5:5000/consul-template-nginx:1.1.1"

        ports = [ "web" ]

        port_map {
          web = 80
        }
      }

      resources {
        cpu    = 1200
        memory = 512
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

