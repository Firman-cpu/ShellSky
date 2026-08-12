import QtQuick
import Quickshell

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 44
    exclusiveZone: 44
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: "#101722ee"
        border.color: "#ffffff18"
        border.width: 1

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            text: "☁  ShellSky"
            color: "#f4f7ff"
            font.pixelSize: 14
            font.weight: Font.DemiBold
        }

        Text {
            id: clock
            anchors.right: parent.right
            anchors.rightMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            color: "#f4f7ff"
            font.pixelSize: 13
            font.weight: Font.DemiBold
            text: Qt.formatDateTime(new Date(), "ddd  HH:mm")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd  HH:mm")
            }
        }
    }
}
