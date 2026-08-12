#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${HOME}/.config/shellsky"
CONFIG_FILE="${CONFIG_DIR}/shellsky.qml"

if ! command -v qs >/dev/null 2>&1 && ! command -v quickshell >/dev/null 2>&1; then
  echo "ShellSky requires Quickshell. Install it with: sudo pacman -S quickshell"
  exit 1
fi

if command -v qs >/dev/null 2>&1; then
  exec qs -c "${CONFIG_FILE}"
fi

exec quickshell -c "${CONFIG_FILE}"
