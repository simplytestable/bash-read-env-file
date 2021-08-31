#!/usr/bin/env bash

CURRENT_DIRECTORY=$(dirname "$0")

OUTPUT_TEMPLATE="::set-output name={{ key }}::{{ value }}" \
"$CURRENT_DIRECTORY"/read-env-file.sh
