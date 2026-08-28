#!/bin/bash

# ==========================================
# Simple service manager
# start / stop / restart a service
# Usage: ./service-manager.sh <service> <action>
# Example: ./service-manager.sh nginx start
# ==========================================

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <service> <start|stop|restart|status>"
    exit 1
fi

SERVICE=$1
ACTION=$2

case "$ACTION" in
    start)
        echo "Starting $SERVICE ..."
        systemctl start $SERVICE && echo "OK: $SERVICE started" || echo "Error: could not start $SERVICE"
        ;;
    stop)
        echo "Stopping $SERVICE ..."
        systemctl stop $SERVICE && echo "OK: $SERVICE stopped" || echo "Error: could not stop $SERVICE"
        ;;
    restart)
        echo "Restarting $SERVICE ..."
        systemctl restart $SERVICE && echo "OK: $SERVICE restarted" || echo "Error: could not restart $SERVICE"
        ;;
    status)
        echo "Status of $SERVICE:"
        systemctl status $SERVICE --no-pager | head -10
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Valid actions: start, stop, restart, status"
        exit 1
        ;;
esac
