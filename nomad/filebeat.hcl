job "filebeat" {
  datacenters = ["dc1"]
  type        = "service"

  group "filebeat" {
    count = 1

    task "filebeat" {
      driver = "docker"

      config {
        image = "docker.elastic.co/beats/filebeat:8.8.0"  # Replace with the desired Filebeat version
      }

      template {
        data = <<EOT
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /logs/file.log   # Replace with the actual path to your log files

output.elasticsearch:
  hosts: ["172.17.0.1:9200"]  
EOT
  destination = "/local/config"
      }

      resources {
        cpu    = 500 
        memory = 256
      }
    }
  }
}

