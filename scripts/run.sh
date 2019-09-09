#!/bin/bash -e

# Arguments
BASE_DIR=$(dirname "$0")
CONFIG_DIR=$1
BIN_NAME=$2
TARGET_PYTHON_VERSION=$3
set -- "${@:4}"

# Configurations
PIP_REQUIREMENTS_CONFIG_FILE="$CONFIG_DIR/pip/requirements"

if [ -f "$PIP_REQUIREMENTS_CONFIG_FILE" ]
then
  PIP_REQUIREMENTS=$(eval echo "$(< "$PIP_REQUIREMENTS_CONFIG_FILE")")
else
  exit 1
fi

# Setup Python
# shellcheck source=/dev/null
source "$BASE_DIR/setup.sh" "$CONFIG_DIR" "$TARGET_PYTHON_VERSION"

# Execute package
pip install --upgrade pip
pip install -r "$PIP_REQUIREMENTS"

if [ -t 1 ]
then
  eval "$BIN_NAME" "$@" < /dev/tty
else
  eval "$BIN_NAME" "$@"
fi
