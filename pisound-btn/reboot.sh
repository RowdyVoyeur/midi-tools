#!/bin/sh

. /usr/local/pisound/scripts/common/common.sh

flash_leds 1
log "Preparing to reboot."

# Clean up audio routing
killall -s SIGINT alsa_out alsa_in

sleep 2

sudo reboot
