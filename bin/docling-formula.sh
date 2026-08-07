#!/usr/bin/env sh

doc="https://arxiv.org/pdf/2503.16322"
args=""

# Parse command line arguments
while [ "$#" -gt 0 ]; do
	case "$1" in
	*)
		# Pass any other arguments directly to docling
		args="$args $1"
		;;
	esac
	shift
done

set -x

# Run docling with the specified document and any additional arguments
uv tool run --with accelerate \
	docling \
	--pipeline vlm \
	--vlm-model smoldocling \
	--to md \
	$args

# --enrich-formula \
# --image-export-mode placeholder \

set +x
