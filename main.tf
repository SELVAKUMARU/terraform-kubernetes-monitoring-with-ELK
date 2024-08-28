provider "kubernetes" {
  config_path = var.kubeconfig
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

#elasticsearch
resource "helm_release" "elasticsearch" {

  name = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  namespace  = var.namespace
  atomic = true
  cleanup_on_fail = true

  set {
    name  = "replicas"
    value = var.elasticsearch_replicas
  }

  set {
    name  = "minimumMasterNodes"
    value = var.elasticsearch_minimumMasterNodes
  }

  set {
    name  = "resources.requests.cpu"
    value = var.elasticsearch_requests_cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.elasticsearch_requests_memory
  }

  set {
    name  = "resources.limits.cpu"
    value = var.elasticsearch_limits_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.elasticsearch_limits_memory
  }

  set {
    name  = "volumeClaimTemplate.resources.requests.storage"
    value = var.elasticsearch_storage
  }

  set {
    name  = "service.type"
    value = var.elasticsearch_service_type
  }

  set {
    name  = "secret.password"
    value = var.elasticsearch_password
  }

  values = [
    file(".terraform/modules/monitoring-with-elastic-stack/configs/elasticsearch/values.yml")
  ]

}

#logstash

resource "helm_release" "logstash" {

  name = "logstash"
  depends_on = [helm_release.elasticsearch]
  repository = "https://helm.elastic.co"
  chart      = "logstash"
  namespace  = var.namespace
  atomic = true
  cleanup_on_fail = true

  set {
    name  = "replicas"
    value = var.logstash_replicas
  }

  set {
    name  = "resources.requests.cpu"
    value = var.logstash_requests_cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.logstash_requests_memory
  }

  set {
    name  = "resources.limits.cpu"
    value = var.logstash_limits_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.logstash_limits_memory
  }

  set {
    name  = "volumeClaimTemplate.resources.requests.storage"
    value = var.logstash_storage
  }

  values = [
    file(".terraform/modules/monitoring-with-elastic-stack/configs/logstash/values.yml")
  ]

}

#filebeat

resource "helm_release" "filebeat" {

  name = "filebeat"
  depends_on = [helm_release.elasticsearch,helm_release.logstash]
  repository = "https://helm.elastic.co"
  chart      = "filebeat"
  namespace  = var.namespace
  atomic = true
  cleanup_on_fail = true

  set {
    name  = "replicas"
    value = var.filebeat_replicas
  }

  set {
    name  = "resources.requests.cpu"
    value = var.filebeat_requests_cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.filebeat_requests_memory
  }

  set {
    name  = "resources.limits.cpu"
    value = var.filebeat_limits_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.filebeat_limits_memory
  }

  values = [
    file(".terraform/modules/monitoring-with-elastic-stack/configs/filebeat/values.yml")
  ]

}

#kibana

resource "helm_release" "kibana" {

  name = "kibana"
  depends_on = [helm_release.elasticsearch,helm_release.logstash,helm_release.filebeat]
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  namespace  = var.namespace
  atomic = true
  cleanup_on_fail = true

  set {
    name  = "replicas"
    value = var.kibana_replicas
  }

  set {
    name  = "resources.requests.cpu"
    value =  var.kibana_requests_cpu
  }

  set {
    name  = "resources.requests.memory"
    value = var.kibana_requests_memory
  }

  set {
    name  = "resources.limits.cpu"
    value = var.kibana_limits_cpu
  }

  set {
    name  = "resources.limits.memory"
    value = var.kibana_limits_memory
  }

  set {
    name  = "service.type"
    value = var.kibana_service_type
  }

  set {
    name  = "ingress.enabled"
    value = var.kibana_ingress_enabled
  }

  set {
    name  = "ingress.ingressClassName"
    value = var.kibana_ingressClassName
  }

  set {
    name  = "ingress.hosts[0].host"
    value = var.kibana_ingress_host
  }

  values = [
    file(".terraform/modules/monitoring-with-elastic-stack/configs/kibana/values.yml")
  ]

}










