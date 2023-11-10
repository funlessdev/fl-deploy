job "init-postgres" {
  datacenters = ["dc1"]

  group "init-postgres" {
    network {
      mode = "host"
    }

    task "init-postgres" {
      driver = "docker"


      #      lifecycle {
      #   hook = "prestart"
      #   sidecar = false
      # }


      template {
        change_mode = "noop"
        destination = "/local/init.sh"

        data = <<EOH
          sh -c "while ! pg_isready -h postgres-postgres-postgres -U postgres; do sleep 1; done; psql -h postgres-postgres-postgres -U postgres -c 'CREATE DATABASE funless;'"
        EOH
      }

      config {
        image = "postgres:latest"
        command = "sh" 
        args = ["/local/init.sh"]
      }

      env {
        POSTGRES_PASSWORD = "postgrespassword"
        POSTGRES_USER     = "postgresuser"
        POSTGRES_HOST_AUTH_METHOD = "trust"
      }

      resources {
        cpu = 200
        memory = 300
      }



    }
  }
}
