job "consul" {
  datacenters = ["dc1"]
  type = "service"
  group "consul" {
    count = 1

    network {
        mode = "host"
     }

    task "consul" {
      driver = "docker"


      config {
        image = "consul:latest"
      }

      resources {
        cpu = 500
        memory = 256
      }

    }
  }
}
