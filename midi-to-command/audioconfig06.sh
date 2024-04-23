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

# Connect audio of M8 Out to MC101 In (Left Channel)
jack_connect M8_in:capture_1 MC101_out:playback_1
jack_connect M8_in:capture_2 MC101_out:playback_1

# Connect audio of USB Card Microphone to MC101 In (Right Channel)
jack_connect system:capture_1 MC101_out:playback_2
# Comment the following line and uncomment the next one, if your USB Card or Audio Card In has a mono ADC
jack_connect system:capture_2 MC101_out:playback_2
# jack_connect system:capture_1 MC101_out:playback_2
