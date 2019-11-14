#!/bin/bash
ID=gohttpd01

rm_files() {
  rm -rf \
	"/usr/local/sbin/$ID" \
	"/lib/systemd/system/$ID.service"
}

remove_systemd() {
    set -x
    systemctl stop "$ID"
    set -uex
    rm_files
    systemctl daemon-reload
    return 0
}

remove_rh6() {
    set -ux
    service "$ID" stop &> /dev/null
    set -uex
    chkconfig --del "$ID"
    rm_files
    return 0
}

hash systemctl &> /dev/null
if [ $? -eq 0 ]; then
    remove_systemd
else
    remove_rh6
fi
