job "kibana-service" {
  datacenters = ["dc1"]
  type        = "service"

  group "elasticsearch" {
    count = 1
    network {
        mode = "bridge"
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
          ELASTICSEARCH_HOSTS    = "http://172.17.0.1:9200"
          ELASTICSEARCH_USERNAME = "kibana_system"
          ELASTICSEARCH_PASSWORD = "password_resetted"
       }
     
      resources {
        cpu = 2000
        memory = 2000
      }

    }
  }
}
