#!/bin/bash

# Start listening to MIDI messages
echo "Script started. Listening to MIDI messages from nanoKONTROL..."

# Restore alsamixer default levels
amixer -D hw:Device sset Speaker 58%
amixer -D hw:Device sset Mic 70%

# Capture MIDI data sent by nanoKONTROL on CC 118 and control Main Output Volume
aseqdump -p "nanoKONTROL" | \
sed -nur 's/^.*controller 118, value (.*)/\1/p' | \
while read l; do
    amixer -D hw:Device sset Speaker "$l"%
    echo "Received MIDI message - CC118: $l"
done &

# Capture MIDI data sent by nanoKONTROL on CC 119 and control Main Input Volume
aseqdump -p "nanoKONTROL" | \
sed -nur 's/^.*controller 119, value (.*)/\1/p' | \
while read l; do
    amixer -D hw:Device sset Mic "$l"%
    echo "Received MIDI message - CC119: $l"
done
