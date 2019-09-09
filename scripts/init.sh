#!/bin/bash -e

DRIVER_NAME="python"
VERSION="0.1.0"
BASE_URL="https://raw.githubusercontent.com/summonbin/python"

# Arguments
INSTALL_PATH=$1
SCHEME_PATH=$2
DEFAULT_CACHE_PATH=$3

# Build driver
mkdir -p "$INSTALL_PATH/$DRIVER_NAME"
curl -L "$BASE_URL/$VERSION/scripts/setup.sh" -o "$INSTALL_PATH/$DRIVER_NAME/setup.sh"
curl -L "$BASE_URL/$VERSION/scripts/python.sh" -o "$INSTALL_PATH/$DRIVER_NAME/python.sh"
curl -L "$BASE_URL/$VERSION/scripts/run.sh" -o "$INSTALL_PATH/$DRIVER_NAME/run.sh"

# Build scheme
mkdir -p "$SCHEME_PATH/$DRIVER_NAME/pyenv"
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/pyenv/cache" ]
then
  echo "$DEFAULT_CACHE_PATH/$DRIVER_NAME/pyenv" > "$SCHEME_PATH/$DRIVER_NAME/pyenv/cache"
fi
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/pyenv/version" ]
then
  echo "v1.2.13" > "$SCHEME_PATH/$DRIVER_NAME/pyenv/version"
fi

mkdir -p "$SCHEME_PATH/$DRIVER_NAME/pip"
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/pip/requirements" ]
then
  echo "requirements.txt" > "$SCHEME_PATH/$DRIVER_NAME/pip/requirements"
fi
