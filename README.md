# gohttpd01

[最新リリース](//github.com/heiwa4126/gohttpd01/releases/latest)の状態は ![GitHub Actionsでエラーなくビルドできたかを示すバッチ](https://github.com/heiwa4126/gohttpd01/workflows/Go/badge.svg) 

Goでデーモンを書いて、systemdの下で動かすテンプレート。

動作は「8081/tcpでhttpを受けてローカルタイムを返す」だけ。
systemdのwatchdogなどに対応している。

# 開発中のbuild

``` bash
go build
```

# install

``` bash
scripts/build.sh
sudo scripts/install.sh
```

バイナリを作り直さないなら`scripts/build.sh`は不要。

# uninstall

``` bash
sudo scripts/remove.sh
```

# 参考
- [Integration of a Go service with systemd: readiness & liveness | Vincent Bernat](https://vincent.bernat.ch/en/blog/2017-systemd-golang)
- [sd_notify](https://www.freedesktop.org/software/systemd/man/sd_notify.html)
- [go-systemd/sdnotify.go at master · coreos/go-systemd](https://github.com/coreos/go-systemd/blob/master/daemon/sdnotify.go)
