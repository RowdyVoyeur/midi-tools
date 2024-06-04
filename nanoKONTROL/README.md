# nanoKONTROL

This section shows the layout of the various nanoKONTROL scenes. This assumes you are using the nanoKONTROL set file found [here](https://github.com/RowdyVoyeur/midi-tools/tree/main/nanoKONTROL).

## Gamepad Controller

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/1.jpg" width="500">

Scene 1 allows to control the M8 with the following buttons of the nanoKONTROL:

| Button | Command | CC | Pitch | Note | Channel |
| --- | --- | --- | --- | --- | --- |
| [P] | Play | - | 0 | C-1 | 16 |
| [S] | Shift | - | 1 | C#-1 | 16 |
| [E] | Edit | - | 2 | D-1 | 16 |
| [O] | Option | - | 3 | D#-1 | 16 |
| [←] | Left | 102 | 4 | E-1 | 16 |
| [→] | Right | 103 | 5 | F-1 | 16 |
| [↑] | Up | 104 | 6 | F#-1 | 16 |
| [↓] | Down | 105 | 7 | G-1 | 16 |

## Mixer, Mute and Solo

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/2.jpg" width="500">

Scene 2 allows to individually Mute and/or Solo Tracks 1 to 8 of the M8 with the following buttons of the nanoKONTROL:

| Button | Command | Pitch | Note | Channel |
| --- | --- | --- | --- | --- |
| [M] | Mute Tracks 1 to 8 | 12 to 19 | C0 to G0 | 16 |
| [S] | Solo Tracks 1 to 8 | 20 to 27 | G#0 to D#1 | 16 |

## Chromatic Keyboard

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/3.jpg" width="500">

Scene 3 is a chromatic keyboard that sends MIDI Notes from the following buttons of the nanoKONTROL:

| Button | Note | Channel |
| --- | --- | --- |
| [A] to [R] | C-1 to F0 | 8 |

## Audio Routing

<img src="https://raw.githubusercontent.com/RowdyVoyeur/midi-tools/main/nanoKONTROL/images/4.jpg" width="500">

Scene 4 allows to select different audio routings and to adjust Alsamixer levels of the System Audio In and Out:

| Button/Knob | Routing/Command | CC | Pitch | Note | Channel |
| --- | --- | --- | --- | --- | --- |
| [A] | [MC101->M8->OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig01.sh) | - | 127 | G9 | 15 |
| [B] | [IN->MC101->M8->OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig02.sh) | - | 126 | F#9 | 15 |
| [C] | [M8->MC101->OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig03.sh) | - | 125 | F9 | 15 |
| [D] | [IN->M8->MC101->OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig04.sh) | - | 124 | E9 | 15 |
| [E] | [M8->MC101 / IN->MC101](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig05.sh) | - | 123 | D#9 | 15 |
| [F] | [IN->MC101(L) / M8->MC101(R)](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig06.sh) | - | 122 | D9 | 15 |
| [G] | [MC101->OUT / M8->OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig07.sh) | - | 121 | C#9 | 15 |
| [H] | [IN->OUT / MC101->OUT / M8->OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig08.sh) | - | 120 | C9 | 15 |
| [I] | [IN->MC101->OUT / IN->M8->OUT](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig09.sh) | - | 119 | B8 | 15 |
| [J] | [M8->MC101](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/audioconfig10.sh) | - | 118 | A#8 | 15 |
| [1] | [Adjust Output Level](https://github.com/RowdyVoyeur/midi-tools/blob/main/control-amixer/control-amixer.sh) | 118 | - | - | 15 |
| [2] | [Adjust Input Level](https://github.com/RowdyVoyeur/midi-tools/blob/main/control-amixer/control-amixer.sh) | 119 | - | - | 15 |
