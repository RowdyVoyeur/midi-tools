# MIDI CC To Note

## Introduction

The ```MidiCCToNote.py``` script uses ```python-rtmidi```  to capture MIDI Control Change (CC) messages sent on a specific MIDI Channel and convert them to MIDI Notes, which will then be pushed to another MIDI Channel.

This tool is basically a customised version of [sherbocopter's](https://github.com/sherbocopter/midi-cc-to-note) script [midi-cc-to-note](https://github.com/sherbocopter/midi-cc-to-note), whith some minor changes to fit my needs. Thank you very much [sherbocopter](https://github.com/sherbocopter) for the phenomenal work.

## Installation

You just need to follow the instructions found [here](https://github.com/RowdyVoyeur/midi-tools/blob/main/README.md#installation).

If you find any rtmidi realted errors, please ensure it is installed by running:
```
sudo pip3 install rtmidi
```
