import QtQuick

Rectangle {
    id: control
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.topMargin: 58
    anchors.rightMargin: 18
    width: 360
    height: 500
    radius: 22
    color: "#141a26f2"
    border.color: "#ffffff18"
    border.width: 1
    visible: false

    Column {
        anchors.fill: parent
        anchors.margins: 22
        spacing: 14

        Text { text: "Control Center"; color: "#f4f7ff"; font.pixelSize: 22; font.weight: Font.DemiBold }

        Grid {
            columns: 2
            spacing: 10
            Repeater {
                model: ["Wi-Fi", "Bluetooth", "Night Light", "Do Not Disturb"]
                delegate: Rectangle {
                    width: 150; height: 72; radius: 16
                    color: "#ffffff08"
                    border.color: "#ffffff10"
                    Text { anchors.centerIn: parent; text: modelData; color: "#dce5f8"; font.pixelSize: 12 }
                }
            }
        }

        Rectangle {
            width: parent.width; height: 92; radius: 16; color: "#ffffff08"
            Column { anchors.fill: parent; anchors.margins: 14; spacing: 8
                Text { text: "Volume"; color: "#9da8bd"; font.pixelSize: 12 }
                Rectangle { width: parent.width; height: 8; radius: 4; color: "#ffffff12"
                    Rectangle { width: parent.width * 0.65; height: parent.height; radius: 4; color: "#8ab4ff" }
                }
            }
        }

        Rectangle {
            width: parent.width; height: 92; radius: 16; color: "#ffffff08"
            Column { anchors.fill: parent; anchors.margins: 14; spacing: 8
                Text { text: "Brightness"; color: "#9da8bd"; font.pixelSize: 12 }
                Rectangle { width: parent.width; height: 8; radius: 4; color: "#ffffff12"
                    Rectangle { width: parent.width * 0.85; height: parent.height; radius: 4; color: "#8ab4ff" }
                }
            }
        }
    }
}