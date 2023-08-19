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
    

    task "curl" {
      lifecycle {
        hook = "prestart"
        sidecar = false
      }

      template {
        change_mode = "noop"
        destination = "/local/request.sh"

        data = <<EOH
         curl -X POST "172.17.0.1:9200/_security/user/SET_USER?pretty" -H 'Content-Type: application/json' -d'
           {
             "password" : "SET_PASSWORD",
             "roles" : ["superuser", "kibana_system"],
             "full_name" : "example",
             "email" : "example@gmail.com",
             "metadata" : {
               "intelligence" : 7
             }
           }
           ' -u elastic:elasticpassword
EOH
      }


      driver = "docker"

      config {
        image = "docker.elastic.co/kibana/kibana:8.8.0"
        ports = ["kibana"]
        command = "sh" 
        args = ["/local/request.sh"]
      }

        env {
          ELASTICSEARCH_HOSTS    = "http://172.17.0.1:9200"
          ELASTICSEARCH_USERNAME = "SET_USER"
          ELASTICSEARCH_PASSWORD = "SET_PASSWORD"
       }
     
      resources {
        cpu = 2000
        memory = 2000
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
          ELASTICSEARCH_USERNAME = "SET_USER"
          ELASTICSEARCH_PASSWORD = "SET_PASSWORD"
       }
     
      resources {
        cpu = 2000
        memory = 2000
      }

    }
  }
}
