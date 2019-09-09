#!/bin/bash -e

# Arguments
BASE_DIR=$(dirname "$0")
CONFIG_DIR=$1
TARGET_PYTHON_VERSION=$2
set -- "${@:3}"

# Setup Python
# shellcheck source=/dev/null
source "$BASE_DIR/setup.sh" "$CONFIG_DIR" "$TARGET_PYTHON_VERSION"

# Execute Python
if [ -t 1 ]
then
  eval python "$@" < /dev/tty
else
  eval python "$@"
fi
