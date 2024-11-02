#!/bin/bash

# Directory containing images
image_dir=$1

shopt -s nullglob
# Get a list of image files in the directory
images="$image_dir/*.{png,jpg,jpeg,gif}"
# Initialize the images array
images=()

# Collect images with specific extensions
for ext in png jpg jpeg gif; do
    images+=("$image_dir"/*."$ext")
done

# Check if the directory contains images
if [ ${#images[@]} -eq 0 ]; then
	echo "No image files found in $image_dir"
	exit 1
fi


# Pick a random image
random_image="${images[RANDOM % ${#images[@]}]}"

# Get the connected outputs from wlr-randr
outputs=$(wlr-randr | rg 'HDMI|DP' | awk '{print $1}')

# Prepare the swaybg command
swaybg_cmd="/usr/bin/swaybg --mode fill"

# Add each output to the command
for output in $outputs; do
	swaybg_cmd+=" --output $output --image \"$random_image\""
done

set -x

# Execute the command
eval "$swaybg_cmd"
