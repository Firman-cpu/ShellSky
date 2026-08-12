import QtQuick
import Quickshell
import Quickshell.Hyprland

QtObject {
    id: root

    readonly property var workspaces: Hyprland.workspaces
    readonly property var activeWorkspace: Hyprland.focusedWorkspace
}
