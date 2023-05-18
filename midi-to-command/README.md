# MIDI To Command

## Introduction

The ```midi2command.py``` script uses ```python-rtmidi``` to capture MIDI messages and execute different external programs and/or scripts when a specific MIDI message is received. A ```configuration``` file defines which program is called, depending on the type and data of the received MIDI message.

The original version of this tool can be found in the [examples](https://github.com/SpotlightKid/python-rtmidi/tree/master/examples) of the [python-rtmidi](https://github.com/SpotlightKid/python-rtmidi). I simply configured it and created the additional scripts to perform the required commands. Thank you very much [SpotlightKid](https://github.com/SpotlightKid) for the amazing repository.

## Configuration

The script takes the name of the [configuration file](https://github.com/RowdyVoyeur/midi-tools/blob/main/midi-to-command/config.cfg) in [YAML](https://yaml.org/spec/1.2.2/) syntax as the first and only positional argument. The configuration consist of a list of mappings, where each mapping defines one command.

Here is a configuration defining two commands. The description of each command explains what it does:
```
- name: Audio Config 1
  description: Connects MC101 to M8 then M8 to System Playback
    when noteon 121 or CS9 is received on Channel 15
  status: noteon
  channel: 15
  data: 121
  command: su patch -c /home/patch/midi-tools/midi-to-command/audioconfig1.sh
- name: Audio Config 2
  description: Connects Audio Input to MC101 then MC101 to M8 then M8 to System Playback
    when noteon 122 or D9 is received on Channel 15
  status: noteon
  channel: 15
  data: 122
  command: su patch -c /home/patch/midi-tools/midi-to-command/audioconfig2.sh
```

The ```status``` key is required and may have one of the following values:

- noteon
- noteoff
- programchange
- controllerchange
- pitchbend
- polypressure
- channelpressure

The value of ```data``` may be a single integer or a list or tuple with one or two integer items. If ```data``` is not present or empty, the configuration matches against any incoming MIDI message. If ```data``` is a single integer or a list or tuple with only one item, only the first data byte of the MIDI message must match.

The command to execute when a matching MIDI message is received is specified with the value of the ```command``` key. This should be the full command line with all needed options and arguments to the external program. The program must be found on your ```path``` or you need to specify the absolute or relative path to the executable. The command will be executed in the current working directory, i.e. the one you started ```midi2command.py``` in.

## Usage

Call the ```midi2command.py``` script with the name of a configuration file as the first argument:
```
sudo python midi2command.py config.cfg
```

You can optionally specify the MIDI input port on which the script should listen for incoming messages with the ```-p``` option. Here's an example:

```
sudo python midi2command.py config.cfg -p nanoKONTROL
```

The port may be specified as an integer or a (case-sensitive) substring of the port name. In the latter case either the first matching port is used, or, if no matching port is found, a list of available input ports is printed and the user is prompted to select one. 

If no port is specified, ```midi2command.py``` opens a virtual MIDI input port.

Here's the full synopsis of the available commands:
```
usage: midi2command.py [-h] [-b {alsa,jack}] [-p PORT] [-v]
                       CONFIG

Execute external commands when specific MIDI messages are received.

positional arguments:
  CONFIG                Configuration file in YAML syntax.

optional arguments:
  -h, --help            show this help message and exit
  -b {alsa,jack}, --backend {alsa,jack}
                        MIDI backend API (default: OS dependant)
  -p PORT, --port PORT  MIDI input port name or number (default: open virtual
                        input)
  -v, --verbose         verbose output
  ```  

## Requirements

Both ```python-rtmidi``` and ```yaml``` are required to run the ```midi2command.py``` script.

If you find any ```rtmidi``` related errors, please ensure it is installed by running:
```
sudo pip3 install rtmidi
```

If you find any ```yaml``` related errors, you may need to update [pyyaml](https://yaml.org/spec/1.2.2/):
```
pip install --upgrade pyyaml
```
