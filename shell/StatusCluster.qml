import QtQuick

Rectangle {
    id: root
    width: row.implicitWidth + 18
    height: 32
    radius: 11
    color: "#ffffff08"

    SystemStatus {
        id: status
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: status.audioReady ? (status.muted ? "󰖁" : "󰕾") + " " + status.volumePercent + "%" : "󰖁"
            color: status.muted ? "#ff9d9d" : "#c9d6eb"
            font.pixelSize: 12
        }

        Text {
            text: status.batteryPercent >= 0 ? "󰁹 " + status.batteryPercent + "%" : "󰁹"
            color: status.onBattery && status.batteryPercent <= 20 ? "#ffb4a8" : "#c9d6eb"
            font.pixelSize: 12
        }
    }
}