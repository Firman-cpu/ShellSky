#!/usr/bin/env bash
set -euo pipefail

QUICKSHELL_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/quickshell"
SHELLSKY_DIR="${QUICKSHELL_DIR}/shellsky"
HYPR_CONF="${HOME}/.config/hypr/hyprland.conf"
BACKUP_DIR="${HOME}/.local/share/shellsky/backups/$(date +%Y%m%d-%H%M%S)"
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
  echo "ShellSky requires Hyprland. Please install/configure Hyprland first."
  exit 1
fi

if [[ ! -f "${SCRIPT_DIR}/shellsky.qml" ]]; then
  echo "ShellSky entrypoint is missing: ${SCRIPT_DIR}/shellsky.qml"
  exit 1
fi

MISSING=()
command -v git >/dev/null 2>&1 || MISSING+=(git)
command -v quickshell >/dev/null 2>&1 || command -v qs >/dev/null 2>&1 || MISSING+=(quickshell)

if (( ${#MISSING[@]} )); then
  echo "Installing required packages: ${MISSING[*]}"
  sudo pacman -S --needed --noconfirm "${MISSING[@]}"
fi

if ! command -v quickshell >/dev/null 2>&1 && ! command -v qs >/dev/null 2>&1; then
  echo "Quickshell installation failed or executable was not found."
  exit 1
fi

if [[ -d "${SHELLSKY_DIR}" ]]; then
  echo "Existing ShellSky configuration found."
  echo "Creating backup: ${BACKUP_DIR}"
  mkdir -p "${BACKUP_DIR}"
  cp -a "${SHELLSKY_DIR}" "${BACKUP_DIR}/shellsky"
fi

mkdir -p "${SHELLSKY_DIR}"
cp "${SCRIPT_DIR}/shellsky.qml" "${SHELLSKY_DIR}/shellsky.qml"
cp "${SCRIPT_DIR}/shellsky.conf" "${SHELLSKY_DIR}/shellsky.conf"
cp -a "${SCRIPT_DIR}/shell/." "${SHELLSKY_DIR}/"
cp -a "${SCRIPT_DIR}/config/." "${SHELLSKY_DIR}/config/"
cp -a "${SCRIPT_DIR}/scripts/." "${SHELLSKY_DIR}/scripts/"

chmod +x "${SHELLSKY_DIR}/scripts/run.sh"
printf '0.1.0\n' > "${SHELLSKY_DIR}/VERSION"

if [[ -f "${HYPR_CONF}" ]]; then
  MARKER="# ShellSky autostart"
  if ! grep -Fq "${MARKER}" "${HYPR_CONF}"; then
    mkdir -p "${BACKUP_DIR}"
    cp -a "${HYPR_CONF}" "${BACKUP_DIR}/hyprland.conf" 2>/dev/null || true
    {
      printf '\n%s\n' "${MARKER}"
      printf 'source = %s\n' "${SHELLSKY_DIR}/config/hyprland/shellsky.conf"
    } >> "${HYPR_CONF}"
    echo "Hyprland autostart enabled."
  else
    echo "Hyprland autostart already configured."
  fi
fi

printf '\nShellSky v0.1.0 installed successfully.\n'
printf 'Configuration: %s\n' "${SHELLSKY_DIR}"
if [[ -d "${BACKUP_DIR}" ]]; then
  printf 'Backup:        %s\n' "${BACKUP_DIR}"
fi
printf '\nRun now without restarting Hyprland:\n'
printf '  %s\n' "${SHELLSKY_DIR}/scripts/run.sh"
printf '\nRestart Hyprland to load automatic startup.\n\n'
