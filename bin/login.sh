#!/bin/bash

set -eu

HOST_NAME=$1

ssh -o StrictHostKeyChecking=no ansible@$HOST_NAME -p 2222 -i $PROJECT_DIR/docker/openssh-server/ssh_key/id_ed25519