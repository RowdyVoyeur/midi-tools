# MIDI PC To Note

## Introduction

This script converts MIDI Program Change (PC) messages into MIDI Note messages. It was specifically designed to allow a Roland MC-101 to trigger the "Song Row Cue" on the **Live Mode** (SEL+LEFT) of the Dirtywave M8 tracker.

The script listens for Program Change messages (0-127) on a specific MIDI channel and translates them into MIDI Note On/Off messages (C-1 to G9) on a target MIDI channel.

By default, the mapping is 1 to 1:
* **PC 0** becomes **Note 0 (C-1)**
* **PC 60** becomes **Note 60 (C4)**
* **PC 127** becomes **Note 127 (G9)**

## Configuration

If you're using the exact same setup comprised of M8 and MC-101, then you can use these settings:

* M8's **SONGROW CUE CH** is set to `15`;
* M8's on **Live Mode**, i.e. `SEL+LEFT`;
* MC-101's **Ctrl Ch** (or MIDI Control Channel) is set to `13`.

If you need to change the MIDI channels, edit the following variables in `main.py`:

```python
SOURCE_CHANNEL = 12  # MIDI Channel 13
TARGET_CHANNEL = 14  # MIDI Channel 15
```

## Usage

### Run manually

To run the script manually, navigate to the folder and execute:

```
cd ~/midi-tools/pc-to-note
python3 main.py
```

### Run on boot

To run the script automatically on boot, add the following line to your m8c.sh script:

```
python3 /home/patch/midi-tools/pc-to-note/main.py &
```

### Final Check

* **Backgrounding:** The `&` is included to ensure the process doesn't block your `m8c` interface.
* **Pathing:** It uses the absolute path `/home/patch/...`, which is the standard for Patchbox OS to ensure the script is found during the boot sequence.

## Requirements

* Raspberry Pi (tested on Pi 4 with Patchbox OS)
* `python-rtmidi` library
* Roland MC-101 and Dirtywave M8
