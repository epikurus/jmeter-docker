#!/bin/sh
set -ex

#jmeter-server -s -Jserver.rmi.localport=50000 -Djava.rmi.server.hostname=localhost "$@"
jmeter-server -Dserver.rmi.localport=50000 -Dserver_port 1099
