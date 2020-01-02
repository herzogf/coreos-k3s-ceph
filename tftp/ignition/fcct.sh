#!/bin/bash

docker pull quay.io/coreos/fcct:latest

rm -f k3s-server.json
docker run -i --rm quay.io/coreos/fcct:latest --pretty --strict < ignition-k3s-server.yaml > k3s-server.json

rm -f k3s-agent.json
docker run -i --rm quay.io/coreos/fcct:latest --pretty --strict < ignition-k3s-agent.yaml > k3s-agent.json
