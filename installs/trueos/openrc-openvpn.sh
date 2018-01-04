#!/sbin/openrc-run

BIN=/usr/local/sbin/openvpn
pid="/var/run/openvpn.pid"
args="$command_args "
name="openvpn"
description="Device State Change Daemon"

depend() {
        #need localmount
        after bootmisc network
        #keyword -jail -prefix -stop
}

start_pre() {
        #sysctl hw.bus.devctl_disable=0 >/dev/null
}

stop_post() {
        #sysctl hw.bus.devctl_disable=1 >/dev/null
}

start() {
        ebegin "Starting $name"
        #start-stop-daemon --start --exec ${BIN} -b -m -p ${pid} -- ${args} >/var/log/devd.log 2>/var/log/devd.log
        service start ${BIN}
        eend $?
}

stop() {
        ebegin "Stopping $name"
        #start-stop-daemon --stop --exec ${BIN} -p ${pid}
        service stop ${BIN}
        eend $?
}#!/sbin/openrc-run

BIN=/sbin/devd
pid="/var/run/devd.pid"
args="$devd_args -d -q"
name="devd"
description="Device State Change Daemon"

depend() {
        need localmount
        after bootmisc network
        keyword -jail -prefix -stop
}

start_pre() {
        sysctl hw.bus.devctl_disable=0 >/dev/null
}

stop_post() {
        sysctl hw.bus.devctl_disable=1 >/dev/null
}

start() {
        ebegin "Starting $name"
        start-stop-daemon --start --exec ${BIN} -b -m -p ${pid} -- ${args} >/var/log/devd.log 2>/var/log/devd.log
        eend $?
}

stop() {
        ebegin "Stopping $name"
        start-stop-daemon --stop --exec ${BIN} -p ${pid}
        eend $?
}#!/sbin/openrc-run

BIN=/sbin/devd
pid="/var/run/devd.pid"
args="$devd_args -d -q"
name="devd"
description="Device State Change Daemon"

depend() {
        need localmount
        after bootmisc network
        keyword -jail -prefix -stop
}

start_pre() {
        sysctl hw.bus.devctl_disable=0 >/dev/null
}

stop_post() {
        sysctl hw.bus.devctl_disable=1 >/dev/null
}

start() {
        ebegin "Starting $name"
        start-stop-daemon --start --exec ${BIN} -b -m -p ${pid} -- ${args} >/var/log/devd.log 2>/var/log/devd.log
        eend $?
}

stop() {
        ebegin "Stopping $name"
        start-stop-daemon --stop --exec ${BIN} -p ${pid}
        eend $?
}