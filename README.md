# MIDI Tools for M8C

## Introduction

This is a set of MIDI tools to use with [M8C running on a Raspberry Pi with Patchbox OS](https://github.com/RowdyVoyeur/m8c-rpi4). These tools have been customised to programmatically perform the following tasks:

- Capture specific MIDI Control Change (CC) messages sent by the transport buttons of the Korg nanoKONTROL and convert them into MIDI Notes to control the M8;

- Capture specific MIDI Note messages sent by the Korg nanoKONTROL and convert them into commands to change the audio routing between USB Card Microphone, M8, MC-101 and System Audio Out.

While the second task can be useful for any setup, the first task is only useful if you have the original version of Korg nanoKONTROL. As far as I know, the following versions of this device can send MIDI Note messages from the transport buttons. Therefore, it is not necessary to convert MIDI CC to MIDI Notes.

### CC To Note

The [CC To Note](https://github.com/RowdyVoyeur/midi-tools/tree/main/cc-to-note) tool uses [python-rtmidi](https://spotlightkid.github.io/python-rtmidi) to capture MIDI Control Change (CC) messages sent on a specific MIDI Channel and convert them to MIDI Notes, which will then be pushed to another MIDI Channel.

This tool is basically a customised version of [sherbocopter's](https://github.com/sherbocopter/midi-cc-to-note) script [midi-cc-to-note](https://github.com/sherbocopter/midi-cc-to-note), whith some minor changes to fit my needs. Therefore, I would like to thank [sherbocopter](https://github.com/sherbocopter) for the phenomenal work.

### MIDI To Command

The [MIDI To Command](https://github.com/RowdyVoyeur/midi-tools/tree/main/midi-to-command) tool also uses [python-rtmidi](https://spotlightkid.github.io/python-rtmidi) to capture MIDI Note messages sent on a specific MIDI Channel and convert them into actions or commands that can perform whatever you wish.

The original version of this tool can be found in the [examples](https://github.com/SpotlightKid/python-rtmidi/tree/master/examples) of the [python-rtmidi](https://github.com/SpotlightKid/python-rtmidi). I simply configured it and created the scripts to perform the required commands. Thank you very much [SpotlightKid](https://github.com/SpotlightKid) for the amazing repository.

## Installation

To install these tools simply clone using:

```
cd
git clone https://github.com/RowdyVoyeur/midi-tools.git
```

It shouldn't be necessary to install ```rtmidi``` because it's already part of [Patchbox OS](https://blokas.io/patchbox-os).

## Configuration

To automatically start these tools on boot, you should edit [m8c.sh](https://github.com/RowdyVoyeur/m8c-rpi4/blob/main/m8c.sh) to include the additional lines of code found in this [example](https://github.com/RowdyVoyeur/midi-tools/blob/main/m8c-example.sh).

Specific information about the configuration of each tool can be found [here](https://github.com/RowdyVoyeur/midi-tools/tree/main/cc-to-note) for CC To Note and [here](https://github.com/RowdyVoyeur/midi-tools/tree/main/midi-to-command) for MIDI To Command.

## nanoKONTROL

This section shows the layout of the various nanoKONTROL scenes. This assumes you are using the nanoKONTROL set file found [here](https://github.com/RowdyVoyeur/midi-tools/tree/main/nanoKONTROL).

### Gamepad Controller

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/1.jpg" width="500">

Scene 1 allows to control the M8 with the following keys of the nanoKONTROL:

[P] is Play - Pitch Value 0 (Note C-1)

[S] is Shift - Pitch Value 1 (Note C#-1)

[E] is Edit - Pitch Value 2 (Note D-1)

[O] is Option - Pitch Value 3 (Note D#-1)

[←] is Left - CC Value 124 converted to Pitch Value 4 (Note E-1)

[→] is Right - CC Value 125 converted to Pitch Value 5 (Note F-1)

[↑] is Up - CC Value 126 converted to Pitch Value 6 (Note F#-1)

[↓] is Down - CC Value 127 converted to Pitch Value 7 (Note G-1)

### Mixer, Mute and Solo

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/2.jpg" width="500">

Scene 2 allows to individually control the Mute and Solo of Channels 1 to 8 of the M8 with the following keys of the nanoKONTROL:

[M] is Mute Channels 1 to 8 - Picth Values 12 to 19 (Notes C0 to G0)

[S] is Solo Channels 1 to 8 - Picth Values 20 to 27 (Notes G#0 to D#1)

### Chromatic Keyboard

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/3.jpg" width="500">

Scene 3 allows sending MIDI Notes from nanoKONTROL keys [A] to [O], basically acting as a chromatic MIDI keyboard.


### Audio Routing

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/4.jpg" width="500">

Scene 4 allows to select the following audio routings:

[A] is [MC101 -> M8 -> OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig1.sh) - Pitch Value 121 (Note C#9)

[B] is [IN -> MC101 -> M8 -> OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig2.sh) - Pitch Value 122 (Note D9)

[C] is [M8 -> MC101 -> OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig3.sh) - Pitch Value 124 (Note E9)

[D] is [IN -> M8 -> MC101 -> OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig4.sh) - Pitch Value 125 (Note F9)

[E] is [MC101 -> OUT | M8 -> OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig5.sh) - Pitch Value 126 (Note F#9)

[F] is [IN -> MC101 -> OUT | IN -> M8 -> OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig6.sh) - Pitch 127 (Note G9)
