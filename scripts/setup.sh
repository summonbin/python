#!/bin/bash -e

# Dependencies
PYENV_REPO_URL="https://github.com/pyenv/pyenv"

# Arguments
CONFIG_DIR=$1
TARGET_PYTHON_VERSION=$2

# Configurations
PYENV_CACHE_CONFIG_FILE="$CONFIG_DIR/pyenv/cache"
PYENV_VERSION_CONFIG_FILE="$CONFIG_DIR/pyenv/version"

if [ -f "$PYENV_CACHE_CONFIG_FILE" ]
then
  PYENV_CACHE_DIR=$(eval echo "$(< "$PYENV_CACHE_CONFIG_FILE")")
else
  exit 1
fi

if [ -f "$PYENV_VERSION_CONFIG_FILE" ]
then
  PYENV_VERSION=$(eval echo "$(< "$PYENV_VERSION_CONFIG_FILE")")
else
  exit 1
fi

# Use system Python
if [ "$TARGET_PYTHON_VERSION" = "system" ]
then
  return
fi

# Clone pyenv
PYENV_REPO_DIR="$PYENV_CACHE_DIR/$PYENV_VERSION"
PYENV_BIN="$PYENV_REPO_DIR/bin/pyenv"

if [ ! -f "$PYENV_BIN" ]
then
  rm -rf "$PYENV_REPO_DIR"
  git clone "$PYENV_REPO_URL" "$PYENV_REPO_DIR" -b "$PYENV_VERSION" --single-branch --depth 1
fi

# Setup pyenv
export PYENV_ROOT="$PYENV_REPO_DIR"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Set Python version
pyenv install -s "$TARGET_PYTHON_VERSION"
export PYENV_VERSION="$TARGET_PYTHON_VERSION"
