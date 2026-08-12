import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
    id: root
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            required property var modelData
            width: modelData.focused ? 28 : 22
            height: 22
            radius: 11
            color: modelData.focused ? "#8ab4ff" : (modelData.active ? "#ffffff18" : "transparent")

            Text {
                anchors.centerIn: parent
                text: modelData.name
                color: modelData.focused ? "#07101f" : "#dce5f8"
                font.pixelSize: 11
                font.weight: modelData.focused ? Font.DemiBold : Font.Normal
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: modelData.activate()
            }
        }
    }
}
