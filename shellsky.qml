import QtQuick
import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                color: "transparent"

                Shell {
                    anchors.fill: parent
                }

                Bar {}
                Dock {}
                Launcher {}
                NotificationCenter {}
            }
        }
    }
}