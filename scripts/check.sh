#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
fail=0

check_cmd() {
  if command -v "$1" >/dev/null 2>&1; then
    printf '  [OK] %s\n' "$1"
  else
    printf '  [!!] %s\n' "$1"
    fail=1
  fi
}

printf '\nShellSky preflight\n==================\n\n'

if [[ -f /etc/arch-release ]]; then
  echo '  [OK] Arch Linux'
else
  echo '  [!!] Arch Linux required'
  fail=1
fi

check_cmd quickshell
check_cmd hyprctl
check_cmd systemctl
check_cmd bash

if command -v qmllint >/dev/null 2>&1; then
  printf '\nQML lint\n--------\n'
  while IFS= read -r -d '' file; do
    printf '  checking %s\n' "${file#"$ROOT_DIR/"}"
    if ! qmllint "$file"; then
      fail=1
    fi
  done < <(find "$ROOT_DIR" -type f -name '*.qml' -print0)
else
  echo '\n[info] qmllint not installed; static QML validation skipped.'
fi

if (( fail )); then
  echo '\nShellSky preflight failed.'
  exit 1
fi

echo '\nShellSky preflight passed.'