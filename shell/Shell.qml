import QtQuick
import QtQuick.Window

Item {
    id: shell
    anchors.fill: parent

    property color backgroundColor: "#080b12"
    property color panelColor: "#141a26cc"
    property color panelBorder: "#ffffff18"
    property color textPrimary: "#f4f7ff"
    property color textSecondary: "#9da8bd"
    property color accent: "#8ab4ff"

    Rectangle {
        anchors.fill: parent
        color: shell.backgroundColor

        Rectangle {
            width: parent.width * 0.55
            height: parent.height * 0.55
            anchors.centerIn: parent
            radius: width
            color: "#1d3152"
            opacity: 0.18
        }

        Rectangle {
            width: parent.width * 0.35
            height: width
            x: parent.width * 0.06
            y: parent.height * 0.18
            radius: width
            color: "#526f9f"
            opacity: 0.10
        }

        Rectangle {
            width: parent.width * 0.28
            height: width
            x: parent.width * 0.72
            y: parent.height * 0.58
            radius: width
            color: "#8a6fff"
            opacity: 0.08
        }
    }

    Text {
        anchors.centerIn: parent
        text: "ShellSky"
        color: shell.textPrimary
        font.pixelSize: 48
        font.weight: Font.DemiBold
    }
}