Find the name of the MIDI device with aconnect -l

aconnect -l:
client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
	Connecting To: 128:0, 129:0
client 14: 'Midi Through' [type=kernel]
    0 'Midi Through Port-0'
	Connecting To: 129:0[real:0]
	Connected From: 129:0
client 16: 'M8' [type=kernel,card=0]
    0 'M8 MIDI 1       '
	Connecting To: 129:0[real:0]
	Connected From: 24:0, 129:0, 130:0[real:0]
client 24: 'nanoKONTROL' [type=kernel,card=2]
    0 'nanoKONTROL nanoKONTROL _ CTRL'
	Connecting To: 16:0, 129:0[real:0], 131:0
	Connected From: 129:0
client 130: 'RtMidiOut Client' [type=user,pid=677]
    0 'M8:M8 MIDI 1 16:0'
	Connecting To: 16:0[real:0], 129:0[real:0]
client 131: 'RtMidiIn Client' [type=user,pid=677]
    0 'nanoKONTROL:nanoKONTROL nanoKONTROL _ CTRL 24:0'
	Connected From: 24:0, 129:0


Find the name of the Simple mixer control with amixer -c 1, where 1 is the number of the Device. You can find the device number with aplay -l

aplay -l:

**** List of PLAYBACK Hardware Devices ****
card 0: M8 [M8], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 1: Device [USB Audio Device], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

amixer -c 1:

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
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

test it with

cd
cd midi-tools/control-amixer
./control-amixer.sh

make script executable by everyone:

sudo chmod a+x *.sh

# Start Control ALSA Mixer (Uncomment the following line to start control-amixer on boot)
sudo /bin/bash /home/patch/midi-tools/control-amixer/control-amixer.sh &

