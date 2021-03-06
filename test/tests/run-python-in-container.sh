#!/bin/bash
set -e

testDir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
runDir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

source "$runDir/run-in-container.sh" "$testDir" "$1" sh -ec '
	for c in python3 python pypy3 pypy; do
		if command -v "$c" > /dev/null; then
			exec "$c" "$@"
		fi
	done
	echo >&2 "error: unable to determine how to run python"
	exit 1
' -- ./container.py
