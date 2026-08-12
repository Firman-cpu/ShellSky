import QtQuick
import Quickshell

QtObject {
    property var apps: []

    function load() {
        // Desktop-entry integration will be enabled in the next runtime stage.
        apps = [
            { name: "Files", command: "dolphin" },
            { name: "Terminal", command: "kitty" },
            { name: "Browser", command: "firefox" },
            { name: "Settings", command: "pavucontrol" }
        ]
    }

    function launch(command) {
        Quickshell.execDetached(["bash", "-lc", command])
    }
}