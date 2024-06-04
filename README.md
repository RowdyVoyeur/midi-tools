# MIDI Tools for M8C

## Introduction

This is a set of MIDI tools to use with [M8C running on a Raspberry Pi with Patchbox OS](https://github.com/RowdyVoyeur/m8c-rpi4). These tools have been customised to programmatically perform the following tasks:

- Capture specific MIDI Control Change (CC) messages sent by the transport buttons of the Korg nanoKONTROL and convert them into MIDI Notes to control the M8;

- Capture specific MIDI Note messages sent by the Korg nanoKONTROL and convert them into commands to change the audio routing between System Audio In, M8, MC-101 and System Audio Out. If you have a [Pisound](https://blokas.io/pisound/docs/), this can also be achieved with this [script](https://github.com/RowdyVoyeur/midi-tools/blob/main/pisound-btn/audio_routing.sh), which uses the clicks on [The Button](https://blokas.io/pisound/docs/the-button/) to change the audio routing;

- Capture specific MIDI Control Change (CC) messages sent by the Korg nanoKONTROL and use them to control the main output and main input volume levels of Alsamixer.

While the second and third tasks can be useful for any setup, the first task is only useful if you have the original version of Korg nanoKONTROL. As far as I know, the following versions of this device can send MIDI Note messages from the transport buttons. Therefore, it is not necessary to convert MIDI CC to MIDI Notes.

### CC To Note

The [CC To Note](https://github.com/RowdyVoyeur/midi-tools/tree/main/cc-to-note) tool uses [python-rtmidi](https://spotlightkid.github.io/python-rtmidi) to capture MIDI Control Change (CC) messages sent on a specific MIDI Channel and convert them to MIDI Notes, which will then be pushed to another MIDI Channel.

This tool is basically a customised version of [sherbocopter's](https://github.com/sherbocopter/midi-cc-to-note) script [midi-cc-to-note](https://github.com/sherbocopter/midi-cc-to-note), whith some minor changes to fit my needs. Therefore, I would like to thank [sherbocopter](https://github.com/sherbocopter) for the phenomenal work.

### MIDI To Command

The [MIDI To Command](https://github.com/RowdyVoyeur/midi-tools/tree/main/midi-to-command) tool also uses [python-rtmidi](https://spotlightkid.github.io/python-rtmidi) to capture MIDI Note messages sent on a specific MIDI Channel and convert them into actions or commands that can perform whatever you wish.

The original version of this tool can be found in the [examples](https://github.com/SpotlightKid/python-rtmidi/tree/master/examples) of the [python-rtmidi](https://github.com/SpotlightKid/python-rtmidi). I simply configured it and created the scripts to perform the required commands. Thank you very much [SpotlightKid](https://github.com/SpotlightKid) for the amazing repository.

### Control Amixer

The [Control Amixer](https://github.com/RowdyVoyeur/midi-tools/tree/main/control-amixer) tool uses `aseqdump`to capture MIDI Control Change (CC) messages and use the data to adjust two `amixer` simple mixer controls, namely `Speaker`and `Mic`, which are responsible for controlling the main output and main input volume levels of Alsamixer.

This tool assumes you are using this [audio configuration](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/AUDIOGUIDE.md), but it can be easily modified for other setups.

## Installation

1. To install these tools simply clone using:
```
cd
git clone https://github.com/RowdyVoyeur/midi-tools.git
```

2. The [MIDI To Command](https://github.com/RowdyVoyeur/midi-tools/tree/main/midi-to-command) uses custom shell scripts. Therefore, you need to get into the `midi-to-command` directory and make all scripts executable by everyone:
```
cd
cd midi-tools/midi-to-command
sudo chmod a+x *.sh
```

3. It shouldn't be necessary to install `rtmidi` because it's already part of [Blokas Patchbox OS](https://blokas.io/patchbox-os). However, you will need to install [pyyaml](https://yaml.org/spec/1.2.2/). Start by installing pip:
```
sudo apt install python3-pip
```

4. And then, install pyyaml:
```
sudo pip3 install pyyaml
```

5. The [Control Amixer](https://github.com/RowdyVoyeur/midi-tools/tree/main/control-amixer) also uses a custom bash script. Therefore, you need to get into the `control-amixer` directory and make the script executable by everyone:
```
cd
cd midi-tools/control-amixer
sudo chmod +x *.sh
```

6. Once the steps above are done, you should test the scripts before automatically start them on boot. Connect the MIDI device(s), reboot and run the following to test `midi-to-command`:
```
cd
sudo python midi-tools/midi-to-command/midi2command.py midi-tools/midi-to-command/config.cfg -p nanoKONTROL
```

7. Run the following to test `cc-to-note`:
```
cd
sudo python midi-tools/cc-to-note/main.py --config midi-tools/cc-to-note/config.json
```

8. And run the following to test `control-amixer`:
```
cd
cd midi-tools/control-amixer
./control-amixer.sh
```

9. If you did not find any errors, you can configure how you would like these tools to automatically start on boot. You can use several methods such as `systemd` or `crontab` to automatically start these tools on boot. However, if you are using the [M8C Module for Patchbox OS](https://github.com/RowdyVoyeur/m8c-rpi4-module) you can simply customise the [m8c.sh](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/m8c.sh) script and uncomment the relevant lines.

10. Specific information about the configuration of each tool can be found [here](https://github.com/RowdyVoyeur/midi-tools/tree/main/cc-to-note#configuration) for CC To Note, [here](https://github.com/RowdyVoyeur/midi-tools/tree/main/midi-to-command#configuration) for MIDI To Command and [here](https://github.com/RowdyVoyeur/midi-tools/tree/main/control-amixer) for Control Amixer.

## MIDI Configuration

You need to configure the MIDI Control Channels on each device to receive data and prevent conflicts.

If you're using the exact same exact setup comprised of M8, MC-101 and Korg nanoKONTROL, then you can use these settings:

- M8's `Control Map Chan` is set to **16**;

- MC-101's `Control Channel` is set to anything different than **8**, **15** or **16** (to prevent MIDI conflicts);

- Korg nanoKONTROL is using this [set file](https://github.com/RowdyVoyeur/midi-tools/tree/main/nanoKONTROL).

If you are using a different setup, then just remember the following default configurations:

- [CC To Note](https://github.com/RowdyVoyeur/midi-tools/tree/main/cc-to-note#midi-cc-to-note) and Korg nanoKONTROL's scenes [1](https://github.com/RowdyVoyeur/midi-tools?tab=readme-ov-file#gamepad-controller) and [2](https://github.com/RowdyVoyeur/midi-tools?tab=readme-ov-file#mixer-mute-and-solo) are sending MIDI data to the M8 on channel 16;

- [MIDI To Command](https://github.com/RowdyVoyeur/midi-tools/tree/main/midi-to-command#midi-to-command) and Korg nanoKONTROL's scene [4](https://github.com/RowdyVoyeur/midi-tools?tab=readme-ov-file#audio-routing) are sending MIDI data to the M8 on channel 15;

- Korg nanoKONTROL's scene [3](https://github.com/RowdyVoyeur/midi-tools?tab=readme-ov-file#chromatic-keyboard) is sending MIDI data to the M8 on channel 8 (you can find more information about this [here](https://github.com/RowdyVoyeur/midi-tools/blob/main/nanoKONTROL/README.md)).

## References

[Download nanoKONTROL editor](https://www.korg.com/us/support/download/software/1/252/1355)

[Convert MIDI Notes to Pitch Values](https://jythonmusic.me/api/midi-constants/pitch)

[Control almost anything using a MIDI controller](http://linux.reuf.nl/projects/midi.htm)
