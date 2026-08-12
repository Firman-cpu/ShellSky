import QtQuick
import Quickshell

PanelWindow {
    id: dock
    required property var shellScreen
    screen: shellScreen
    anchors { bottom: true; left: true; right: true }
    implicitHeight: 86
    exclusiveZone: 0
    color: "transparent"

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14
        width: Math.min(parent.width - 48, 420)
        height: 60
        radius: 20
        color: "#0b2340dd"
        border.color: "#9acbff30"
        border.width: 1

        Row {
            anchors.centerIn: parent
            spacing: 8

            Repeater {
                model: [
                    { icon: "󰀻", label: "Apps" },
                    { icon: "󰉋", label: "Files" },
                    { icon: "󰈹", label: "Browser" },
                    { icon: "󰆍", label: "Terminal" },
                    { icon: "󰙨", label: "Editor" },
                    { icon: "⚙", label: "Settings" }
                ]

                delegate: Rectangle {
                    id: appButton
                    required property var modelData
                    width: 44
                    height: 44
                    radius: 14
                    color: mouse.containsMouse || index === 0 ? "#72b8ff20" : "#ffffff07"
                    border.color: mouse.containsMouse || index === 0 ? "#9acbff35" : "transparent"

                    Behavior on color { ColorAnimation { duration: 140 } }

                    Text {
                        anchors.centerIn: parent
                        text: modelData.icon
                        color: mouse.containsMouse || index === 0 ? "#9bd0ff" : "#d9ebff"
                        font.pixelSize: 18
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }
            }
        }
    }
}
