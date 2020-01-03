#!/bin/bash

docker pull quay.io/coreos/fcct:latest

rm -f ../tftp/fcos/k3s-server.json
docker run -i --rm quay.io/coreos/fcct:latest --pretty --strict < k3s-server.yaml > ../tftp/fcos/k3s-server.json

rm -f ../tftp/fcos/k3s-agent.json
docker run -i --rm quay.io/coreos/fcct:latest --pretty --strict < k3s-agent.yaml > ../tftp/fcos/k3s-agent.json
