variable "namespace" {
    default = "elastic-monitoring"
    description = "all the resources will deploy here"
}

variable "kubeconfig" {
  type    = string
  default = "/var/lib/jenkins/.kube/config"
}

## elasticsearch

variable "elasticsearch_replicas" {
  type    = number
  default = 1
}

variable "elasticsearch_minimumMasterNodes" {
  type    = number
  default = 1
}

variable "elasticsearch_requests_cpu" {
  type    = string
  default = "100m"
}

variable "elasticsearch_requests_memory" {
  type    = string
  default = "512M"
}

variable "elasticsearch_limits_cpu" {
  type    = string
  default = "1000m"
}

variable "elasticsearch_limits_memory" {
  type    = string
  default = "1Gi"
}

variable "elasticsearch_storage" {
  type    = string
  default = "2Gi"
}

variable "elasticsearch_service_type" {
  type    = string
  default = "ClusterIP"
}

variable "elasticsearch_password" {
  type    = string
  default = "admin123"
}

#logstash

variable "logstash_replicas" {
  type    = number
  default = 1
}

variable "logstash_requests_cpu" {
  type    = string
  default = "100m"
}

variable "logstash_requests_memory" {
  type    = string
  default = "1536Mi"
}

variable "logstash_limits_cpu" {
  type    = string
  default = "1000m"
}

variable "logstash_limits_memory" {
  type    = string
  default = "1536Mi"
}

variable "logstash_storage" {
  type    = string
  default = "2Gi"
}

# filebeat

variable "filebeat_replicas" {
  type    = number
  default = 1
}

variable "filebeat_requests_cpu" {
  type    = string
  default = "100m"
}

variable "filebeat_requests_memory" {
  type    = string
  default = "100Mi"
}

variable "filebeat_limits_cpu" {
  type    = string
  default = "1000m"
}

variable "filebeat_limits_memory" {
  type    = string
  default = "200Mi"
}

#kibana

variable "kibana_replicas" {
  type    = number
  default = 1
}

variable "kibana_requests_cpu" {
  type    = string
  default = "1000m"
}

variable "kibana_requests_memory" {
  type    = string
  default = "1Gi"
}

variable "kibana_limits_cpu" {
  type    = string
  default = "1000m"
}

variable "kibana_limits_memory" {
  type    = string
  default = "1Gi"
}

variable "kibana_service_type" {
  type    = string
  default = "NodePort"
}

variable "kibana_ingress_enabled" {
  type    = bool
  default = true
}

variable "kibana_ingressClassName" {
  type    = string
  default = "nginx"
}

variable "kibana_ingress_host" {
  type    = string
  default = "kibana.francium.com"
}

















