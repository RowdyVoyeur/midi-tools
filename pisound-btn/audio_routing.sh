#!/bin/sh

. /usr/local/pisound/scripts/common/common.sh

case "$1" in
        "1")
        # MC101->OUT / M8->OUT
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig07.sh
        ;;
        "2")
        # IN->MC101->OUT / IN->M8->OUT
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig09.sh
        ;;
        "3")
        # MC101->M8->OUT
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig01.sh
        ;;
        "4")
        # IN->MC101->M8->OUT
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig02.sh
        ;;
        "5")
        # M8->MC101->OUT
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig03.sh
        ;;
        "6")
        # IN->M8->MC101->OUT
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig04.sh
        ;;
        "7")
        # M8->MC101 / IN->MC101
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig05.sh
        ;;
        "8")
        # IN->MC101(L) / M8->MC101(R)
        su patch -c /home/patch/midi-tools/midi-to-command/audioconfig06.sh
        ;;
        esac

flash_leds 100
