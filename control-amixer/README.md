# Control Amixer

## Introduction

The `control-amixer.sh` script uses `aseqdump`to capture MIDI Control Change (CC) messages sent by an external MIDI controller, such as `nanoKONTROL`, and use the data to adjust `amixer` simple mixer controls. The command `aseqdump` shows the events received at an ALSA sequencer port, while `amixer` is a command line mixer for ALSA soundcard driver.

In this particular case, it's controlling `Speaker`and `Mic` simple mixer controls, which are responsible for controlling the main output and main input volume levels of Alsamixer. I created this script from scratch with very little knowledge about the topic, so feel free to reach out with suggestions for improvements.

## Configuration

This tool assumes you are using this [audio configuration](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/AUDIOGUIDE.md), but it can be easily modified for other setups. To configure it for other setups, you will need to do the following:

1. First you'll need to find the name of the MIDI controller by typing `aconnect -l` in Terminal. Here's my output of `aconnect -l`:
```
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
	Connecting To: 128:0, 129:0
client 16: 'M8' [type=kernel,card=0]
    0 'M8 MIDI 1       '
	Connecting To: 129:0[real:0]
	Connected From: 24:0, 129:0, 130:0[real:0]
client 24: 'nanoKONTROL' [type=kernel,card=2]
    0 'nanoKONTROL nanoKONTROL _ CTRL'
	Connecting To: 16:0, 129:0[real:0], 131:0
	Connected From: 129:0
```

2. Then, you can go to the script and add the MIDI device name after `aseqdump -p`. In my case, it looks like this `aseqdump -p "nanoKONTROL"`. This will ensure the script will listen to MIDI messages coming from that particular MIDI device.

3. You also need to configure which CC will be captured. In this case, I'm capturing CC 118 and CC 119. Then, the script should look like this for CC 118 `sed -nur 's/^.*controller 118`.

4. Find the name of the name of audio device you wish to control in Alsamixer using `aplay -l`. Here's my output:
```
List of PLAYBACK Hardware Devices
card 0: M8 [M8], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 1: Device [USB Audio Device], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
```

5. Then, you can go to the script and add the audio device name after `amixer -D hw:`. Since I'm using `card 1`, I need to use the name `Device` in the script. In my case, it looks like this `amixer -D hw:Device`.

6. Find the names of the simple mixer controls you wish to control by typing `amixer -c N` in Terminal, where `N` is the card number of the audio device you wish to control. Here's my output of `amixer -c 1`:
```
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 37
  Mono:
  Front Left: Playback 24 [65%] [-13.00dB] [on]
  Front Right: Playback 24 [65%] [-13.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined cvolume cvolume-joined pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: Playback 0 - 31 Capture 0 - 35
  Mono: Playback 14 [45%] [-9.00dB] [off] Capture 16 [46%] [4.00dB] [on]
```

7. Then add the name of the simple mixer control after `amixer -D hw:Device sset`. In my case, it looks like this `amixer -D hw:Device sset Speaker` for main output level and `amixer -D hw:Device sset Mic` for main input level.

## Usage

You need to get into the `control-amixer` directory and make the script executable by everyone:
```
cd
cd midi-tools/control-amixer
sudo chmod a+x *.sh
```

Then, to run the script simply type the following in Terminal:
```
./control-amixer.sh
```

## Requirements

This script uses `aseqdump` and `amixer` commands, which are both part of [alsa-utils](https://github.com/alsa-project/alsa-utils). If you are using [Blokas Patchbox](https://blokas.io/patchbox-os), you don't need to install anything, because this is part of the OS.
