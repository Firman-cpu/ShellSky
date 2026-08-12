import QtQuick
import Quickshell
import "./shell"

ShellRoot {
    Variants {
        variants: Quickshell.screens

        Item {
            required property var modelData

            PanelWindow {
                screen: modelData
                anchors { top: true; bottom: true; left: true; right: true }
                color: "transparent"
                exclusiveZone: 0

                Shell {
                    anchors.fill: parent
                }
            }

            TopBar {
                shellScreen: modelData
            }

            BottomDock {
                shellScreen: modelData
            }
        }
    }
}
