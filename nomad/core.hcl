 job "core-service" {
  datacenters = ["dc1"]
  type        = "service"

  group "core" {
    count = 1

    network {
        mode = "bridge"
        port "funless" {
          static = 4000
        }
     }

    task "core" {
      driver = "docker"

      config {
        image = "ghcr.io/funlessdev/core:latest"
        ports = ["funless"]
      }

      env {
        PGHOST            = "postgresuser"
        PGUSER            = "postgresuser"
        PGPASSWORD        = "postgrespassword"
        PGDATABASE        = "funless"
        PGPORT            = "5432"
        SECRET_KEY_BASE   = "agoodexampleofasecretkey"
      }
    }
  }
} 
