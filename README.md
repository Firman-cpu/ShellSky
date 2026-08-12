# ShellSky

A modern Linux desktop shell for Wayland, built for Arch Linux and Hyprland.

## Status

ShellSky is currently in the foundation stage. The first release focuses on a safe installer and a minimal shell runtime layout.

## Target stack

- Arch Linux
- Wayland
- Hyprland
- Quickshell / QML
- systemd / D-Bus

## Installation

```bash
git clone https://github.com/Firman-cpu/ShellSky.git
cd ShellSky
./install.sh
```

The installer checks the system, installs required packages with `pacman`, creates a backup of existing ShellSky configuration, and installs the shell files under `~/.config/shellsky`.

## Development

The project is intentionally being built in stages:

1. Foundation and installer
2. Shell runtime
3. Desktop surface
4. Bar and dock
5. Launcher
6. Notifications
7. Control center
8. Overview
9. Settings
10. Lock screen and power menu

## License

MIT
