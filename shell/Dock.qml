import QtQuick

Rectangle {
    id: dock
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 18
    width: Math.min(parent.width - 40, 430)
    height: 68
    radius: 20
    color: "#141a26dd"
    border.color: "#ffffff18"
    border.width: 1

    Row {
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: ["●", "◆", "■", "▲", "✦", "●"]

            delegate: Rectangle {
                width: 46
                height: 46
                radius: 14
                color: index === 0 ? "#8ab4ff22" : "#ffffff08"

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    color: index === 0 ? "#8ab4ff" : "#dce5f8"
                    font.pixelSize: 17
                }
            }
        }
    }
}