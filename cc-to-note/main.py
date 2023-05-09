import time
import logging
import sys
from MidiCCToNote import Controller, Config, NoteSingle as NS, NoteBatch as NB
import argparse

# Args
parser = argparse.ArgumentParser(description='Read Midi CC messages and output Note on/off.')
parser.add_argument('--config', required=True, type=str, nargs=1, help='json config file')
parser.add_argument('--debug', action='store_const', const=True)
args = parser.parse_args()

# Logging
if args.debug:
	rootLogger = logging.getLogger()
	rootLogger.setLevel(logging.DEBUG)
	formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
	ch = logging.StreamHandler(sys.stdout)
	ch.setFormatter(formatter)
	rootLogger.addHandler(ch)

# Run
configPath = args.config[0]
app = Controller(configPath)
app.start()

# KeepAlive
print("Press Control-C to exit.")
try:
	while True:
		time.sleep(1)
except KeyboardInterrupt:
	pass
finally:
	print("Exit.")
	app.stop()
