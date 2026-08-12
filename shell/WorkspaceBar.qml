import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: root
    width: Math.min(parent.width * 0.42, 420)
    height: 34
    radius: 12
    color: "#ffffff08"
    border.color: "#ffffff0d"

    Row {
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                required property var modelData
                width: Math.max(28, label.implicitWidth + 18)
                height: 26
                radius: 9
                color: modelData.focused ? "#8ab4ff28" : modelData.active ? "#ffffff0d" : "transparent"
                border.color: modelData.focused ? "#8ab4ff55" : "transparent"

                Text {
                    id: label
                    anchors.centerIn: parent
                    text: modelData.name || String(modelData.id)
                    color: modelData.focused ? "#dbe8ff" : modelData.urgent ? "#ff9d9d" : "#8d9ab0"
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