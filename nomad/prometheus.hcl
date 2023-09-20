job "prometheus" {
  datacenters = ["dc1"]
  type        = "service"

  group "monitoring" {
    count = 1

    network {
      port "prometheus_ui" {
        static = 9090
      }
    }

    task "prometheus" {
      template {
        change_mode = "noop"
        destination = "local/prometheus.yml"

        data = <<EOH
---
global:
  scrape_interval: 5s
  evaluation_interval: 5s

  external_labels:
    monitor: "funless"

# Targets to scrape
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
  - job_name: "funless"
    static_configs:
      - targets: ["core:4000", "worker:4021"]
EOH
      }

      driver = "docker"

      config {
        image = "prom/prometheus:latest"

        volumes = [
          "local/prometheus.yml:/etc/prometheus/prometheus.yml",
        ]

        ports = ["prometheus_ui"]
      }

       service {
         tags = ["prometheus"]
         port = "kibana"
         provider = "consul"
       }

    }
  }
}

