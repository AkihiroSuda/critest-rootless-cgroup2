#!/bin/bash
set -eux
SYSTEMCTL="systemctl --user"
SERVICE="containerd.service"
$SYSTEMCTL --kill-who all --signal KILL kill $SERVICE
$SYSTEMCTL stop $SERVICE
$SYSTEMCTL reset-failed $SERVICE
