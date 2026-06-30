#!/usr/bin/env python3
import sys
import os
import subprocess

def stream_audio_data():
    # command to start our silent background audio analyzer
    cava_cmd = ["cava", "-p", os.path.expanduser("~/dotfiles/cava/config")]
    
    # launch cava as a background data pipeline process
    process = subprocess.Popen(cava_cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)

    try:
        while True:
            line = process.stdout.readline()
            if not line:
                break
            
            # split the raw string of ascii numbers into separate values
            frequencies = line.strip().split(";")
            if len(frequencies) > 1:
                # calculate the average amplitude to capture the overall bass/energy
                valid_values = [int(v) for v in frequencies if v.isdigit()]
                if valid_values:
                    average_energy = sum(valid_values) // len(valid_values)
                    
                    # flush out the single average number clean for quickshell to read
                    sys.stdout.write(f"{average_energy}\n")
                    sys.stdout.flush()
    except KeyboardInterrupt:
        process.terminate()

if __name__ == "__main__":
    stream_audio_data()
