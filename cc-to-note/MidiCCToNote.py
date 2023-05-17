import rtmidi
import rtmidi.midiutil
import sys
import logging
import json

class _MidiTranslateHandler(object):
	def __init__(self, config, midiout):
		self._config = config
		self._midiout = midiout

	def __call__(self, event, data=None):
		inputMessage, deltatime = event
		statusByte = inputMessage[0]
		dataByte1 = inputMessage[1]
		dataByte2 = inputMessage[2]

		LOG.debug('Got ' + str(inputMessage))
		
		channel = self._extractChannel(statusByte)
		if((channel is None) or (channel != self._config.inputChannel)):
			return

		nb = self._config.ccTranslationMap.get(dataByte1)
		if(nb is not None):
			LOG.debug(str(dataByte1) + " => " + str(list(map(lambda ns : (ns.pitch, ns.velocity), nb.notes))))
			for ns in nb.notes:
				if dataByte2 > 0:
					self._midiout.send_message(ns.getMessage(True))
					if nb.shortFire:
						self._midiout.send_message(ns.getMessage(False))
				else:
					self._midiout.send_message(ns.getMessage(False))

	def _extractChannel(self, statusByte):
		channel = statusByte ^ 176
		if (channel > 15):
			LOG.debug('Not a CC. Ignoring.')
		else:
			return channel + 1

class NoteSingle(object):
	def __init__(self, pitch, velocity):
		self.pitch = pitch
		self.velocity = velocity

	@classmethod
	def fromJson(cls, data):
		pitch = data["pitch"]
		velocity = data["velocity"]

		return cls(pitch, velocity)

	def getMessage(self, on=True, channel=16): # Change the output MIDI channel here
		statusByte = 0x90 if on else 0x80
		statusByte |= (channel - 1)  # Subtract 1 from channel to get the correct MIDI channel

		return [statusByte, self.pitch, self.velocity]

class NoteBatch(object):
	def __init__(self, notes, shortFire=False):
		self.notes = notes
		self.shortFire = shortFire

	@classmethod
	def fromJson(cls, data):
		notes = list(map(NoteSingle.fromJson, data["notes"]))
		shortFire = data["shortFire"]

		return cls(notes, shortFire)


class Config(object):
	def __init__(self, inputPortName=None, outputPortName=None, inputChannel=None, outputChannel=None, ccTranslationMap=None):
		self.inputPortName = inputPortName
		self.outputPortName = outputPortName
		self.inputChannel = inputChannel
		self.outputChannel = outputChannel
		self.ccTranslationMap = ccTranslationMap

		self._midiin = None

	@classmethod
	def fromJson(cls, data):
		inputPortName = data["inputPortName"]
		outputPortName = data["outputPortName"]
		inputChannel = data["inputChannel"]
		outputChannel = data["outputChannel"]
		ccTranslationMap = dict(map(lambda i: (int(i[0]), NoteBatch.fromJson(i[1])), data["ccTranslationMap"].items()))

		return cls(inputPortName, outputPortName, inputChannel, outputChannel, ccTranslationMap)

class Controller(object):
	def __init__(self, configPath):
		with open(configPath, 'r') as f:
			configJson = json.load(f)
		self._config = Config.fromJson(configJson)
		self._validateConfig()

		self._midiin = None
		self._midiout = None

	def _validateConfig(self):
		pass
	
	def start(self):
		self._midiout, inputPort = rtmidi.midiutil.open_midioutput(self._config.outputPortName)
		self._midiin, outputPort = rtmidi.midiutil.open_midiinput(self._config.inputPortName)
		self._midiin.set_callback(_MidiTranslateHandler(self._config, self._midiout))

	def stop(self):
		self._midiout.close_port()
		self._midiin.close_port()

LOG = logging.getLogger(__name__)
