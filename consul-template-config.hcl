consul {
  address = "10.8.0.1:8500"
  retry {
    enabled = true
    attempts = 12
    backoff = "250ms"

  }
}
template {
  source = "/etc/nginx/conf.d.template/load-balancer.conf.ctmpl"
  destination = "/etc/nginx/conf.d/load-balancer.conf"
  perms = 0600
  command = "/usr/sbin/reload-nginx"
}
