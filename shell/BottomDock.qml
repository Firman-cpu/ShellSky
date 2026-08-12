import QtQuick
import Quickshell

PanelWindow {
    id: dock
    anchors.bottom: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 92
    color: "transparent"

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14
        width: Math.min(parent.width - 48, 460)
        height: 64
        radius: 22
        color: "#101722e8"
        border.color: "#ffffff18"
        border.width: 1

        Row {
            anchors.centerIn: parent
            spacing: 9

            Repeater {
                model: ["●", "◆", "■", "▲", "✦", "●"]
                delegate: Rectangle {
                    width: 44
                    height: 44
                    radius: 14
                    color: index === 0 ? "#8ab4ff25" : "#ffffff09"
                    border.color: index === 0 ? "#8ab4ff45" : "#ffffff10"

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: index === 0 ? "#8ab4ff" : "#dce5f8"
                        font.pixelSize: 16
                    }
                }
            }
        }
    }
}
