	job "fl-worker" {
  datacenters = ["dc1"]
  type        = "system"

  group "fl-worker" {
    count = 1

    network {
      mode = "host"
      port "first" {
      	static = 4021
      }
      port "second" {
      	static = 4369
      }
    }
    
    task "worker" {
      driver = "docker"

      config {
        image = "ghcr.io/funlessdev/worker:latest"
        ports = [
          "first",
          "second"
        ]
      }
      
      env {
        NODE_IP    = "${attr.unique.network.ip-address}"
      }

      resources {
        cpu    = 500
        memory = 2000
      }
    }
  }
}
