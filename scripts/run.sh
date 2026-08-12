#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v quickshell >/dev/null 2>&1 && ! command -v qs >/dev/null 2>&1; then
    echo "ShellSky: quickshell is not installed."
    echo "Install it with: sudo pacman -S quickshell"
    exit 1
fi

if ! command -v hyprctl >/dev/null 2>&1; then
    echo "ShellSky: Hyprland was not detected."
    exit 1
fi

QS="$(command -v quickshell || command -v qs)"
exec "$QS" --path "$ROOT_DIR/shellsky.qml"
