job "elasticsearch" {
  datacenters = ["dc1"]

  group "elasticsearch" {
    count = 1

    network {
      mode = "bridge"
      port "elastic" {}
    }

    task "elastic_container" {
      driver = "docker"

      env = {
        "ES_JAVA_OPTS"           = "-Xms512m -Xmx512m"
        "ELASTIC_USER"           = "elastic"
        "ELASTIC_PASSWORD"       = "elasticpassword"
        "discovery.type"         = "single-node"
        "bootstrap.memory_lock"  = "true"
        "xpack.license.self_generated.type" = "basic"
        "xpack.security.enabled" = "true"
        "xpack.security.authc.api_key.enabled" = "true"
      }

      config {
        network_mode = "host"
        image = "docker.elastic.co/elasticsearch/elasticsearch:8.8.0"
        ports = ["elastic"]
      }

      resources {
        cpu    = 5000
        memory = 1000
      }
    }
  }
}
