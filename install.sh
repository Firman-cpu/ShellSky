#!/usr/bin/env bash
set -euo pipefail

SHELLSKY_DIR="${HOME}/.config/shellsky"
HYPR_CONF="${HOME}/.config/hypr/hyprland.conf"
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
  echo "ShellSky requires Hyprland. Please install/configure Hyprland first."
  exit 1
fi

MISSING=()
command -v git >/dev/null 2>&1 || MISSING+=(git)
command -v quickshell >/dev/null 2>&1 || command -v qs >/dev/null 2>&1 || MISSING+=(quickshell)

if (( ${#MISSING[@]} )); then
  echo "Installing required packages: ${MISSING[*]}"
  sudo pacman -S --needed --noconfirm "${MISSING[@]}"
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

cp "${SCRIPT_DIR}/shellsky.qml" "${SHELLSKY_DIR}/shellsky.qml"
cp "${SCRIPT_DIR}/shellsky.conf" "${SHELLSKY_DIR}/shellsky.conf"
cp -a "${SCRIPT_DIR}/shell/." "${SHELLSKY_DIR}/shell/"
cp -a "${SCRIPT_DIR}/config/." "${SHELLSKY_DIR}/config/"
cp -a "${SCRIPT_DIR}/scripts/." "${SHELLSKY_DIR}/scripts/"

chmod +x "${SHELLSKY_DIR}/scripts/run.sh"

cat > "${SHELLSKY_DIR}/VERSION" <<'EOF'
0.1.0
EOF

# Enable ShellSky automatically in Hyprland, without duplicating the entry.
if [[ -f "${HYPR_CONF}" ]]; then
  MARKER="# ShellSky autostart"
  if ! grep -Fq "${MARKER}" "${HYPR_CONF}"; then
    cp -a "${HYPR_CONF}" "${HYPR_CONF}.shellsky-backup-$(date +%Y%m%d-%H%M%S)"
    {
      printf '\n%s\n' "${MARKER}"
      printf 'source = %s/config/hyprland/shellsky.conf\n' "${SHELLSKY_DIR}"
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
printf '\nRestart Hyprland to load the automatic startup configuration.\n\n'