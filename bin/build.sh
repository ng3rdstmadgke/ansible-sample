#!/bin/bash

DOCKERFILE_DIR="$(cd $(dirname $0)/../docker; pwd)"
cd $DOCKERFILE_DIR
docker build -t keitamido/ansible:latest -f "${DOCKERFILE_DIR}/Dockerfile" .
