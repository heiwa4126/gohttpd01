package main

import (
	"net/http"
	"time"
	"log"
	"github.com/heiwa4126/gohttpd01/daemon" // `go get github.com/coreos/go-systemd` failed on go module
)

func Start() error {
	const layout = "2006-01-02 15:04:05 MST"

	http.HandleFunc("/",
		func(writer http.ResponseWriter, request *http.Request) {
			res := append( []byte(time.Now().Format(layout)), 0x0a)
			writer.Write(res)
		})

	// systemdのwatchdog
	interval, err := daemon.SdWatchdogEnabled(false)
	if err != nil {
		return err
	}
	if interval != 0 {
		go func() {
			for {
				daemon.SdNotify(false, daemon.SdNotifyWatchdog)
				time.Sleep(interval / 3)
			}
		}()
	}

	// 準備完了をsystemdに送信
	daemon.SdNotify(false, daemon.SdNotifyReady)

	http.ListenAndServe(":8080", nil)
	return nil
}

func main() {
	log.SetFlags(log.Flags() &^ (log.Ldate | log.Ltime)) // for systemd
	log.Println("auditconv started.")

	Start()
}
