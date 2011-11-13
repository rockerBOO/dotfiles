#!/bin/sh
#
# git-extension
#
# Examples:
#

usage() {
	echo "usage:"
}

main() {
    if [ $# -lt 1 ]; then
        usage
        exit 1
    fi

    local SUBCOMMAND="$1"
    shift

    if ! type "cmd_$SUBCOMMAND" >/dev/null 2>&1; then
        echo "Unknown subcommand: '$SUBCOMMAND'"
        usage
        exit 1
    fi
        
    cmd_$SUBCOMMAND "$@"
}

main "$@"

