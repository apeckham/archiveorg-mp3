#!/bin/bash

set -ex

filename=$(basename -- "$1")
base="${filename%.*}"

# Get the audio bitrate from the source file
bitrate=$(ffprobe -v error -select_streams a:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "$1")

# Convert to mp3 using the same bitrate
ffmpeg -i "$1" -b:a ${bitrate} -vn "${base}.mp3"

# Normalize the audio levels
ffmpeg-normalize "${base}.mp3" -o "${base}.mp3" -f -c:a libmp3lame

# Remove the original file
rm "$1"
