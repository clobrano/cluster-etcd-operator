#!/usr/bin/env bash

# example
# sudo ./etcd-member-remove.sh $etcd_name

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

usage () {
    echo 'The name of the etcd member to remove is required: ./etcd-member-remove.sh $etcd_name'
    exit 1
}

if [ "$1" == "" ]; then
    usage
fi

ETCD_NAME=$1
ASSET_DIR=/home/core/assets
ASSET_DIR_TMP="$ASSET_DIR/tmp"
ETCDCTL=$ASSET_DIR/bin/etcdctl
ETCD_DATA_DIR=/var/lib/etcd
CONFIG_FILE_DIR=/etc/kubernetes

source "/usr/local/bin/openshift-recovery-tools"

function run {
  init
  dl_etcdctl
  backup_etcd_client_certs
  etcd_member_remove $ETCD_NAME
}

run

