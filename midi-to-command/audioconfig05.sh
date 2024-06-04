#!/bin/bash

# Get list of connected ports
connected_ports=$(jack_lsp -c | grep -v '^ ')

if [[ -z "$connected_ports" ]]; then
    echo "No connected ports found"
else
    echo "Connected ports:"
    echo "$connected_ports"
    # Loop through each connected port
    while read -r port; do
        # Get list of connections for this port
        connections=$(jack_lsp -c "$port" | grep '^ ')

        if [[ -z "$connections" ]]; then
            echo "No connections found for: $port"
        else
            # Disconnect each connection for this port
            while read -r connection; do
                echo "Disconnecting: $port -> ${connection#*> }"
                jack_disconnect "$port" "${connection#*> }"
            done <<< "$connections"
        fi
    done <<< "$connected_ports"
fi

sleep 1

# Audio Routing: M8->MC101 / IN->MC101

# Check if the Instrument with the Card Name "MC101" is connected to the Raspberry Pi
# Use "aplay -l" to find the Card Name of any connected audio devices
if [ $(aplay -l | grep -c "MC101") -eq 0 ]; then
  echo "MC101 not detected, skipping connection."
  
  # Connect audio of M8 Out to System In if MC101 is not detected
  jack_connect M8_in:capture_1 system:playback_1
  jack_connect M8_in:capture_2 system:playback_2
  
  # Connect audio of USB Card Microphone or Audio Card In to M8 In if MC101 is not detected
  # If USB Card or Audio Card In has a Mono ADC, use system:capture_1 in both lines, which creates a fake stereo
  jack_connect system:capture_1 M8_out:playback_1
  jack_connect system:capture_2 M8_out:playback_2
  
else
  echo "MC101 detected, connecting."

# Connect audio of M8 Out to MC101 In
# If MC101 is in Vendor Driver Mode, use MC101_out:playback_3 and MC101_out:playback_4
# If MC101 is in Generic Driver Mode, use MC101_out:playback_1 and MC101_out:playback_2
jack_connect M8_in:capture_1 MC101_out:playback_3
jack_connect M8_in:capture_2 MC101_out:playback_4

# Connect audio of USB Card Microphone or Audio Card In to MC101 In (This allows to record audio onto the MC101)
# If USB Card or Audio Card In has a Mono ADC, use system:capture_1 in both lines, which creates a fake stereo
# If MC101 is in Vendor Driver Mode, use MC101_out:playback_3 and MC101_out:playback_4
# If MC101 is in Generic Driver Mode, use MC101_out:playback_1 and MC101_out:playback_2
jack_connect system:capture_1 MC101_out:playback_3
jack_connect system:capture_2 MC101_out:playback_4

fi
