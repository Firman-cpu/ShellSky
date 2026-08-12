#!/usr/bin/env bash
set -euo pipefail

SHELLSKY_DIR="${HOME}/.config/shellsky"
BACKUP_DIR="${HOME}/.config/shellsky-backup-$(date +%Y%m%d-%H%M%S)"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

printf '\n  ShellSky installer\n  ==================\n\n'

if [[ "${EUID}" -eq 0 ]]; then
  echo "Do not run this installer as root."
  exit 1
fi

if [[ ! -f /etc/arch-release ]]; then
  echo "ShellSky currently targets Arch Linux."
  exit 1
fi

if ! command -v hyprctl >/dev/null 2>&1; then
  echo "Warning: Hyprland was not detected. ShellSky is designed for Hyprland."
fi

if ! command -v git >/dev/null 2>&1; then
  echo "Installing git..."
  sudo pacman -S --needed --noconfirm git
fi

if [[ -d "${SHELLSKY_DIR}" ]]; then
  echo "Existing ShellSky configuration found."
  echo "Creating backup: ${BACKUP_DIR}"
  cp -a "${SHELLSKY_DIR}" "${BACKUP_DIR}"
fi

mkdir -p \
  "${SHELLSKY_DIR}" \
  "${SHELLSKY_DIR}/shell" \
  "${SHELLSKY_DIR}/config" \
  "${SHELLSKY_DIR}/themes" \
  "${SHELLSKY_DIR}/assets" \
  "${SHELLSKY_DIR}/scripts"

if [[ -f "${SCRIPT_DIR}/shellsky.conf" ]]; then
  cp "${SCRIPT_DIR}/shellsky.conf" "${SHELLSKY_DIR}/shellsky.conf"
fi

if [[ -d "${SCRIPT_DIR}/shell" ]]; then
  cp -a "${SCRIPT_DIR}/shell/." "${SHELLSKY_DIR}/shell/"
fi

if [[ -d "${SCRIPT_DIR}/config" ]]; then
  cp -a "${SCRIPT_DIR}/config/." "${SHELLSKY_DIR}/config/"
fi

if [[ -d "${SCRIPT_DIR}/themes" ]]; then
  cp -a "${SCRIPT_DIR}/themes/." "${SHELLSKY_DIR}/themes/"
fi

cat > "${SHELLSKY_DIR}/VERSION" <<'EOF'
0.1.0
EOF

printf '\nShellSky foundation installed.\n'
printf 'Configuration: %s\n' "${SHELLSKY_DIR}"
if [[ -d "${BACKUP_DIR}" ]]; then
  printf 'Backup:        %s\n' "${BACKUP_DIR}"
fi
printf '\nNext stage: ShellSky runtime and desktop shell.\n\n'
