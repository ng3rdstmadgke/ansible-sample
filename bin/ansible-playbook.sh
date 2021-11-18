#!/bin/bash

# localhostに対しての実行では使えないので注意

PROJECT_DIR="$(cd $(dirname $0)/..; pwd)"
cd $PROJECT_DIR

HOST_UID="$(id -u $(whoami))"
HOST_GID="$(id -g $(whoami))"

# -v ${PROJECT_DIR}:/ansible  /ansible にansibleプロジェクトをマウント
# -v ${HOME}:/home/user       ホストの.ssh/, .ansible/ を参照する
# -e HOST_UID=${HOST_UID}     ホスト側の実行ユーザーのUIDを渡す
# -e HOST_GID=${HOST_GID}     ホスト側の実行ユーザーのGIDを渡す
docker run -it --rm --privileged \
  -v ${PROJECT_DIR}:/ansible \
  -v ${HOME}:/home/user \
  -e HOST_UID=${HOST_UID} \
  -e HOST_GID=${HOST_GID} \
  keitamido/ansible:latest ansible-playbook $@
