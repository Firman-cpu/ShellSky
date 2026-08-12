#!/usr/bin/env bash
set -euo pipefail

ok=0
fail=0
check() {
  if command -v "$1" >/dev/null 2>&1; then
    printf '  [OK] %s\n' "$1"
    ((ok+=1))
  else
    printf '  [--] %s\n' "$1"
    ((fail+=1))
  fi
}

printf '\nShellSky system check\n======================\n\n'
check quickshell
check hyprctl
check systemctl
check bash
printf '\nAvailable: %d\nMissing:   %d\n\n' "$ok" "$fail"
