#!/usr/bin/env bash

VER=$1

docker build -t "10.8.0.5:5000/consul-template-nginx:${VER}" .
docker push "10.8.0.5:5000/consul-template-nginx:${VER}"
export NOMAD_ADDR="http://10.8.0.1:4646"
nomad job run nginx-consul-loadbalancer.nomad
