#!/bin/bash

# HOST_UID=${変数名:-デフォルト値}
HOST_UID=${LOCAL_UID:-1000}
HOST_GID=${LOCAL_GID:-1000}

# ホスト側の実行ユーザーと同一のUID, GIDを持つユーザーを作成
echo "Starting with UID : $HOST_UID, GID: $HOST_GID"
useradd -u $HOST_UID -o --no-create-home user
groupmod -g $HOST_GID user
export HOME=/home/user

# 作成したユーザーでコマンドを実行
exec /usr/sbin/gosu user "$@"
