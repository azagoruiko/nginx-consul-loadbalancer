#!/usr/bin/env bash

VER=$1

docker build -t "192.168.0.21:9999/docker/consul-template-nginx:${VER}" .
docker push "192.168.0.21:9999/docker/consul-template-nginx:${VER}"
export NOMAD_ADDR="http://192.168.0.21:4646"
nomad job run nginx-consul-loadbalancer.nomad
