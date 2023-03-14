#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./scaleimages.sh input/images/x.png ../prs/

Upscales images 4x using realesrgan-ncnn-vulkan

Note: output directory must end in a slash
'
	exit
fi

main() {
	if [[ $(file "$1" | sed -n '/directory/') ]]; then
		for file in "$1"/*.png; do

			filename=$(basename "$file")
			/mnt/900/builds/prs/real/realesrgan-ncnn-vulkan -i "$file" -o "$2$filename"
		done
	else
		filename=$(basename "$1")
		echo "/mnt/900/builds/prs/real/realesrgan-ncnn-vulkan -i ""$1"" -o ""$2$filename"""
		/mnt/900/builds/prs/real/realesrgan-ncnn-vulkan -i "$1" -o "$2$filename"
	fi
}

main "$@"
