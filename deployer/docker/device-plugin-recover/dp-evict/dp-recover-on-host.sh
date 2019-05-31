#!/usr/bin/env bash

set -e -x

dir="/etc/kubernetes/manifests"
backup_dir="/etc/kubernetes/manifests-backup"

public::common::log() {
	echo $(date +"[%Y%m%d %H:%M:%S]: ") $1
}

public::recover::gpu-device-plugin() {

    if [  -f $dir/nvidia-device-plugin.yml ]; then
		public::common::log "Skip recovering nvidia-device-plugin.yml, because it already exist."
    else
		mv -f $backup_dir/nvidia-device-plugin.yml $dir/nvidia-device-plugin.yml
		public::common::log "Finish recovering nvidia-device-plugin.yml."
	fi
}

main() {

	public::recover::gpu-device-plugin

	touch /ready
}

main "$@"
