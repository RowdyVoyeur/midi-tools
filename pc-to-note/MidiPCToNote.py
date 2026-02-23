import time
import rtmidi
from rtmidi.midiconstants import PROGRAM_CHANGE, NOTE_ON, NOTE_OFF

# MIDI configuration (0-indexed in Python)
# MC-101 Source Channel: 13 (index 12)
# M8 Target Channel: 15 (index 14)
SOURCE_CHANNEL = 12
TARGET_CHANNEL = 14

def main():
    midi_in = rtmidi.MidiIn()
    midi_out = rtmidi.MidiOut()

    # Get available ports
    in_ports = midi_in.get_ports()
    out_ports = midi_out.get_ports()

    # Dynamic port discovery
    mc101_idx = next((i for i, name in enumerate(in_ports) if "MC-101" in name), None)
    m8_idx = next((i for i, name in enumerate(out_ports) if "M8" in name), None)

    if mc101_idx is None or m8_idx is None:
        print("Error: Required hardware not detected.")
        print(f"Detected Inputs: {in_ports}")
        print(f"Detected Outputs: {out_ports}")
        return

    # Open the identified ports
    midi_in.open_port(mc101_idx)
    midi_out.open_port(m8_idx)

    print(f"--- MIDI Tool: pc-to-note ---")
    print(f"Input:  {in_ports[mc101_idx]} (Ch 13)")
    print(f"Output: {out_ports[m8_idx]} (Ch 15)")
    print(f"Mapping: PC 0-127 -> MIDI Notes 0-127")
    print("-----------------------------")

    def midi_callback(event, data=None):
        message, timestamp = event
        status = message[0] & 0xF0
        channel = message[0] & 0x0F

        # Filter for Program Change on Source Channel
        if status == PROGRAM_CHANGE and channel == SOURCE_CHANNEL:
            pc_value = message[1]
          
            # Prepare Note messages
            note_on = [NOTE_ON | TARGET_CHANNEL, pc_value, 100]
            note_off = [NOTE_OFF | TARGET_CHANNEL, pc_value, 0]

            # Send to M8
            midi_out.send_message(note_on)
            time.sleep(0.001) # Short gate for hardware trigger stability
            midi_out.send_message(note_off)
            
            print(f"PC {pc_value} converted to Note {pc_value}")

    midi_in.set_callback(midi_callback)

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("\nExiting pc-to-note.")
    finally:
        midi_in.close_port()
        midi_out.close_port()

if __name__ == "__main__":
    main()
