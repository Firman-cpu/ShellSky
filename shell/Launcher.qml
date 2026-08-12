import QtQuick
import QtQuick.Controls

Rectangle {
    id: launcher
    anchors.centerIn: parent
    width: Math.min(parent.width - 80, 720)
    height: 420
    radius: 24
    color: "#141a26ee"
    border.color: "#ffffff18"
    border.width: 1
    visible: false

    Column {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 18

        Text {
            text: "Applications"
            color: "#f4f7ff"
            font.pixelSize: 24
            font.weight: Font.DemiBold
        }

        TextField {
            id: search
            width: parent.width
            placeholderText: "Search applications..."
            color: "#f4f7ff"
            placeholderTextColor: "#72809a"
            background: Rectangle {
                radius: 14
                color: "#ffffff08"
                border.color: "#ffffff12"
            }
        }

        Grid {
            columns: 4
            spacing: 12
            Repeater {
                model: ["Files", "Browser", "Terminal", "Settings", "Music", "Editor", "System", "Help"]
                delegate: Rectangle {
                    width: 140
                    height: 74
                    radius: 14
                    color: "#ffffff08"
                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: "#dce5f8"
                        font.pixelSize: 13
                    }
                }
            }
        }
    }
}