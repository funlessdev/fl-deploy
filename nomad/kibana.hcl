job "kibana-service" {
  datacenters = ["dc1"]
  type        = "service"

  group "kibana" {
    count = 1
    network {
        mode = "host"
        port "kibana" {
          static = 5601
        }
     }
    
    task "kibana" {
      driver = "docker"

      config {
        image = "docker.elastic.co/kibana/kibana:8.8.0"
        ports = ["kibana"]
      }

        env {
          SERVERNAME             = "kibana"
          ELASTICSEARCH_HOSTS    = "https://elastic.local:9200"
          ELASTICSEARCH_USERNAME = "kibana_system"
          ELASTICSEARCH_PASSWORD = "elasticpassword"
        }
     
      resources {
        cpu = 2000
        memory = 2000
      }

    }
  }
}
