#!/usr/bin/env sh

# we want ffmpeg to conver the video to audio
# then we can get the transcript from the audio

file=$(mktemp)

ffmpeg -y -i "$1" -vn -acodec pcm_s16le -ac 1 -ar 16000 -f wav "$file"
whisper "$file" --output-txt --output-file "${1%.*}"

rm "$file"
