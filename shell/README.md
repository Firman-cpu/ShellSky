# ShellSky UI

The v0.1 shell is built with Quickshell and QtQuick.

Components:

- `Shell.qml` — desktop background and visual surface
- `Bar.qml` — top panel
- `Dock.qml` — application dock
- `Launcher.qml` — application launcher surface
- `NotificationCenter.qml` — notification panel
- `ControlCenter.qml` — quick controls
- `Clock.qml` — live clock
- `Theme.qml` — shared visual tokens

The UI is intentionally modular so services and Hyprland integration can be added without redesigning the visual layer.