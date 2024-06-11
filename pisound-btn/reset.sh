#!/bin/sh

. /usr/local/pisound/scripts/common/common.sh

flash_leds 1
log "Preparing to reset audio connections."

# Clean up audio routing
killall -s SIGINT alsa_out alsa_in

sleep 2

# Check if the Instrument with the Card Name "MC101" is connected to the Raspberry Pi
if [ $(aplay -l | grep -c "MC101") -eq 0 ]; then
  echo "MC101 not detected, skipping connection."
else
  echo "MC101 detected, connecting."

# Open audio interface between MC101 Out and System In
# alsa_in options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
# If MC101 is in Vendor Driver Mode, use -c 10. This creates ports for 10 Channels Out: 1+2 Main Out; 3+4 Track1; 5+6 Track2; 7+8 Track3; 9+10 Track4
# If MC101 is in Generic Driver Mode, use -c 2 or do not set this option. This creates ports for 2 Channels Out
alsa_in -j "MC101_in" -d hw:MC101,DEV=0 -r 44100 -p 64 -n 4 -c 10 &

# Open audio interface between System Out and MC101 In
# alsa_out options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
# If MC101 is in Vendor Driver Mode, use -c 4. This creates ports for 4 Channels In: 1+2 Main In, bypassing controls; 3+4 Main In, allows controls
# If MC101 is in Generic Driver Mode, use -c 2. This creates ports for 2 Channels In
alsa_out -j "MC101_out" -d hw:MC101,DEV=0 -r 44100 -p 64 -n 4 -c 4 &

sleep 4

# Connect audio of MC101 Out to System In (This allows to hear the MC101)
jack_connect MC101_in:capture_1 system:playback_1
jack_connect MC101_in:capture_2 system:playback_2

# Connect audio of USB Card Microphone or Audio Card In to MC101 In (This allows to record audio onto the MC101)
# If USB Card or Audio Card In has a Mono ADC, use system:capture_1 in both lines, which creates a fake stereo
# If MC101 is in Vendor Driver Mode, use MC101_out:playback_3 and MC101_out:playback_4
# If MC101 is in Generic Driver Mode, use MC101_out:playback_1 and MC101_out:playback_2
# Uncomment the lines below if you with to make these connections upon reset audio connections
# jack_connect system:capture_1 MC101_out:playback_3
# jack_connect system:capture_2 MC101_out:playback_4

fi

# Open audio interface between M8 Out and System In
# alsa_in options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
alsa_in -j "M8_in" -d hw:M8,DEV=0 -r 44100 -p 64 -n 4 -c 2 &

# Open audio interface between System Out and M8 In
# alsa_out options: -r is Sample Rate, -p is Period or Buffer Size, -n is Period, -q is Quality, -c is Channels
alsa_out -j "M8_out" -d hw:M8,DEV=0 -r 44100 -p 64 -n 4 -c 2 &

sleep 4

# Connect audio of M8 Out to System In (This allows to hear the M8)
jack_connect M8_in:capture_1 system:playback_1
jack_connect M8_in:capture_2 system:playback_2

# Connect audio of USB Card Microphone or Audio Card In to M8 In (This allows to record audio onto the M8)
# If USB Card or Audio Card In has a Mono ADC, use system:capture_1 in both lines, which creates a fake stereo
jack_connect system:capture_1 M8_out:playback_1
jack_connect system:capture_2 M8_out:playback_2
