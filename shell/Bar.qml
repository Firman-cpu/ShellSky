import QtQuick
import QtQuick.Controls

Rectangle {
    id: bar
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 42
    color: "#141a26cc"
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

    Row {
        anchors.right: parent.right
        anchors.rightMargin: 18
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16

        Text { text: "Wi-Fi"; color: "#9da8bd"; font.pixelSize: 12 }
        Text { text: "Audio"; color: "#9da8bd"; font.pixelSize: 12 }
        Text { text: "100%"; color: "#9da8bd"; font.pixelSize: 12 }
        Text {
            text: Qt.formatDateTime(new Date(), "HH:mm")
            color: "#f4f7ff"
            font.pixelSize: 13
            font.weight: Font.DemiBold
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: bar.update()
    }

    function update() {}
}