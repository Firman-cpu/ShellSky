import QtQuick

Rectangle {
    id: notifications
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.topMargin: 58
    anchors.rightMargin: 18
    width: 340
    height: 420
    radius: 20
    color: "#141a26ee"
    border.color: "#ffffff18"
    border.width: 1
    visible: false

    Column {
        anchors.fill: parent
        anchors.margins: 22
        spacing: 14

        Text {
            text: "Notifications"
            color: "#f4f7ff"
            font.pixelSize: 20
            font.weight: Font.DemiBold
        }

        Rectangle {
            width: parent.width
            height: 82
            radius: 14
            color: "#ffffff08"

            Column {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 6
                Text { text: "ShellSky"; color: "#f4f7ff"; font.pixelSize: 13; font.weight: Font.DemiBold }
                Text { text: "Welcome to your new desktop shell."; color: "#9da8bd"; font.pixelSize: 12; wrapMode: Text.WordWrap; width: parent.width }
            }
        }
    }
}