import QtQuick

Text {
    property string format: "HH:mm"
    color: "#f4f7ff"
    font.pixelSize: 13
    font.weight: Font.DemiBold
    text: Qt.formatDateTime(new Date(), format)

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: parent.text = Qt.formatDateTime(new Date(), parent.format)
    }
}