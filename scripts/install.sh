#!/bin/bash
ID=gohttpd01

install_systemd() {
    set -x
    systemctl stop "$ID"
    set -uex
    install -o root -g root -m 0700 "$ID" /usr/local/sbin/
    install -o root -g root -m 0644 "scripts/initscript/$ID.service" /lib/systemd/system/
    systemctl daemon-reload
    systemctl enable "$ID" --now
    systemctl status "$ID" -l
}

install_rh6() {
    set -ux
    service "$ID" stop &> /dev/null
    set -uex
    install -o root -g root -m 0700 "$ID" /usr/local/sbin/
    install -o root -g root -m 0755 "scripts/initscript/$ID-sysvinit-rh6" "/etc/init.d/$ID"
    chkconfig --add "$ID"
    service "$ID" start
    return 0
}

hash systemctl &> /dev/null
if [ $? -eq 0 ]; then
    install_systemd
else
    install_rh6
fi
