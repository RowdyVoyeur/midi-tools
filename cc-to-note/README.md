# MIDI CC To Note

## Introduction

The ```MidiCCToNote.py``` script uses ```python-rtmidi```  to capture MIDI Control Change (CC) messages sent on a specific MIDI Channel and convert them to MIDI Notes, which will then be pushed to another MIDI Channel.

This tool is basically a customised version of [sherbocopter's](https://github.com/sherbocopter/midi-cc-to-note) script [midi-cc-to-note](https://github.com/sherbocopter/midi-cc-to-note), whith some minor changes to fit my needs. Thank you very much [sherbocopter](https://github.com/sherbocopter) for the phenomenal work.

## Installation

You just need to follow the instructions found [here](https://github.com/RowdyVoyeur/midi-tools/blob/main/README.md#installation).

## Configuration

You should use this [configuration file](https://github.com/RowdyVoyeur/midi-tools/blob/main/cc-to-note/config.json) or create a different version to specify the following values:

- inputPortName
- inputChannel
- outputPortName
- outputChannel

The value of ```inputChannel``` and ```outputChannel``` may be a single integer. The ```inputPortName``` and ```outputPortName``` should be the port name, which can be found using ``` aconnect -l```.

Please note that, as far as I can tell, the ```outputChannel``` is not working properly. So, in order to select the ```outputChannel```, I manually edited the [MidiCCToNote.py](https://github.com/RowdyVoyeur/midi-tools/blob/main/cc-to-note/MidiCCToNote.py) and changed the following:

```
def getMessage(self, on=True, channel=16): # Change the output MIDI channel here, in this case it's channel 16
```

You can then specify the incoming ```Control Change``` value, the output ```Pitch``` value and ```Velocity``` value. Here's an example capturing ```Control Change``` 120 and converting it to ```Pitch``` 4 (E-1) with a ```Velocity``` of 127:
```
"120": {
                        "shortFire": false,
                        "notes": [
                                {"pitch": 4, "velocity": 127}
                        ]
                }
```

## Usage

Call the ```main.py``` script, followed by ```--config``` and the name of a configuration file:

```
sudo python main.py --config config.json
```
Alternatively, you can also use ```--debug``` to see what is happening:
```
sudo python main.py --config config.json --debug
```

## Requirements and Troubleshooting

The ```python-rtmidi``` is required to run the ```MidiCCToNote.py``` script.

If you find any rtmidi related errors, please ensure it is installed by running:
```
sudo pip3 install rtmidi
```

## References

[Full details about midi-cc-to-note](https://github.com/sherbocopter/midi-cc-to-note)

[MIDI pitch values](https://jythonmusic.me/api/midi-constants/pitch)
