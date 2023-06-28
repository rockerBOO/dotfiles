#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
	set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
	echo 'Usage: ./jpgtowebp.sh

Converts jpg to webp inside the current directory
'
	exit
fi

main() {
	for file in *.jpg; do cwebp -q 50 "$file" -o "${file%.*}.webp"; done
}

main "$@"
