# Pisound - The Button

## Introduction

[The Button](https://blokas.io/pisound/docs/the-button/) is a customizable button on the Pisound board, which allows the user to create mappable actions.

I created a script that changes the audio routing of all the devices connected to the Paspbery Pi. So, for example, when I press The Button three times, the [script](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/audio_routing.sh) will change the default audio routing (MC-101 -> Pisound Out / Pisound In -> M8 -> Pisound Out) to a different one (MC-101 -> M8 -> Pisound Out). The number of button clicks will dictate the audio routing:

| Clicks | Routing |
| --- | --- |
| 1 | MC101->OUT / M8->OUT |
| 2 | IN->MC101->OUT / IN->M8->OUT |
| 3 | MC101->M8->OUT |
| 4 | IN->MC101->M8->OUT |
| 5 | M8->MC101->OUT |
| 6 | IN->M8->MC101->OUT |
| 7 | M8->MC101 / IN->MC101 |
| 8 | IN->MC101(L) / M8->MC101(R) |

Additionally, there is another [script](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/reboot.sh) to clean up the audio routing and reboot.

## Configuration

1. The first step is to clone the [midi-tools](https://github.com/RowdyVoyeur/midi-tools/) repo:
```
cd
git clone https://github.com/RowdyVoyeur/midi-tools.git
```  

2. The audio routing [script](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/audio_routing.sh) uses custom shell scripts also used by [midi-to-command](https://github.com/RowdyVoyeur/midi-tools/tree/main/midi-to-command). Therefore, you need to get into the midi-to-command directory and make all scripts executable by everyone:
```
cd
cd midi-tools/midi-to-command
sudo chmod +x *.sh
```

3. Then, you need to move [audio_routing.sh](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/audio_routing.sh) and [reboot.sh](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/reboot.sh) scripts to the folder `/usr/local/pisound/scripts/pisound-btn` and make them executable by everyone. Alternatively, you can create the files in the correct folder and copy all contents onto them. Here's an example of how to do it for audio_routing.sh:
```
cd /usr/local/pisound/scripts/pisound-btn
sudo touch audio_routing.sh && sudo chmod +x audio_routing.sh
sudo nano audio_routing.sh
```

4. Once the [audio_routing.sh](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/audio_routing.sh) file is in the correct folder and with the right permissions, run `pisound-config`:
```
sudo pisound-config
```

5. Set `CLICK_1`, `CLICK_2`, `CLICK_3` and `CLICK_OTHER`to execute the [audio_routing.sh](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/audio_routing.sh) script.

6. Set, for example `HOLD_3S ` to execute the [reboot.sh](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/reboot.sh) and, if you're not using Bluetooth, you can also set `HOLD_1S` to [do_nothing.sh](https://github.com/BlokasLabs/pisound/blob/master/scripts/pisound-btn/do_nothing.sh).

## Requirements

Clone [midi-tools](https://github.com/RowdyVoyeur/midi-tools/).
