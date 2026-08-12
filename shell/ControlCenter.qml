import QtQuick
import Quickshell

PanelWindow {
    id: panel
    anchors.top: true
    anchors.right: true
    implicitWidth: 360
    implicitHeight: 560
    margins.top: 58
    margins.right: 18
    color: "transparent"
    visible: false
    focusable: true

    Rectangle {
        anchors.fill: parent
        radius: 24
        color: "#121a27f5"
        border.color: "#ffffff1c"
        border.width: 1

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 18

            Text { text: "Control Center"; color: "#f4f7ff"; font.pixelSize: 22; font.weight: Font.DemiBold }

            Repeater {
                model: ["Wi-Fi", "Bluetooth", "Night Light", "Do Not Disturb"]
                delegate: Rectangle {
                    width: parent.width
                    height: 58
                    radius: 14
                    color: "#ffffff08"
                    border.color: "#ffffff0d"
                    Text { anchors.left: parent.left; anchors.leftMargin: 16; anchors.verticalCenter: parent.verticalCenter; text: modelData; color: "#dce5f8"; font.pixelSize: 13 }
                    Text { anchors.right: parent.right; anchors.rightMargin: 16; anchors.verticalCenter: parent.verticalCenter; text: index < 2 ? "ON" : "OFF"; color: index < 2 ? "#8ab4ff" : "#72809a"; font.pixelSize: 11; font.weight: Font.DemiBold }
                }
            }

            Text { text: "Quick Settings"; color: "#9da8bd"; font.pixelSize: 12; font.weight: Font.DemiBold }
        }
    }
}
