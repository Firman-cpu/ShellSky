import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: root
    width: Math.min(parent.width * 0.34, 360)
    height: 36
    radius: 14
    color: "#72b8ff0d"
    border.color: "#9acbff22"
    border.width: 1

    Row {
        anchors.centerIn: parent
        spacing: 4

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                required property var modelData
                width: Math.max(30, label.implicitWidth + 18)
                height: 28
                radius: 10
                color: modelData.focused ? "#72b8ff38" : modelData.active ? "#72b8ff12" : "transparent"
                border.color: modelData.focused ? "#9acbff45" : "transparent"

                Behavior on color { ColorAnimation { duration: 140 } }

                Text {
                    id: label
                    anchors.centerIn: parent
                    text: modelData.name || String(modelData.id)
                    color: modelData.focused ? "#eef8ff" : modelData.urgent ? "#ffb5c0" : "#9db7d2"
                    font.pixelSize: 11
                    font.weight: modelData.focused ? Font.DemiBold : Font.Normal
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: modelData.activate()
                }
            }
        }
    }
}
