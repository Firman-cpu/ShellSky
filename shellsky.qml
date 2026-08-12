import QtQuick
import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: Component {
            Item {
                required property var modelData

                PanelWindow {
                    screen: modelData
                    anchors { top: true; bottom: true; left: true; right: true }
                    color: "#080b12"
                    aboveWindows: false
                    focusable: false

                    Rectangle {
                        anchors.fill: parent
                        color: "#080b12"

                        Rectangle {
                            width: parent.width * 0.55
                            height: parent.height * 0.55
                            anchors.centerIn: parent
                            radius: width
                            color: "#233d66"
                            opacity: 0.20
                        }

                        Rectangle {
                            width: parent.width * 0.30
                            height: width
                            x: parent.width * 0.08
                            y: parent.height * 0.18
                            radius: width
                            color: "#526f9f"
                            opacity: 0.09
                        }
                    }
                }

                TopBar { shellScreen: modelData }
                BottomDock { shellScreen: modelData }
            }
        }
    }
}