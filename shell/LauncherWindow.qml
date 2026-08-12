import QtQuick
import Quickshell

PanelWindow {
    id: launcher
    anchors.fill: true
    color: "transparent"
    visible: false
    focusable: true

    Rectangle {
        anchors.fill: parent
        color: "#05070bcc"

        Rectangle {
            anchors.centerIn: parent
            width: Math.min(parent.width - 80, 720)
            height: 440
            radius: 26
            color: "#121a27f5"
            border.color: "#ffffff1c"
            border.width: 1

            Column {
                anchors.fill: parent
                anchors.margins: 28
                spacing: 18

                Text {
                    text: "Applications"
                    color: "#f4f7ff"
                    font.pixelSize: 24
                    font.weight: Font.DemiBold
                }

                Rectangle {
                    width: parent.width
                    height: 48
                    radius: 14
                    color: "#ffffff09"
                    border.color: "#ffffff12"

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Search applications..."
                        color: "#72809a"
                        font.pixelSize: 13
                    }
                }

                Grid {
                    columns: 4
                    spacing: 12
                    Repeater {
                        model: ["Files", "Browser", "Terminal", "Settings", "Music", "Editor", "System", "Help"]
                        delegate: Rectangle {
                            width: 148
                            height: 76
                            radius: 14
                            color: "#ffffff08"
                            border.color: "#ffffff0d"
                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: "#dce5f8"
                                font.pixelSize: 13
                            }
                        }
                    }
                }
            }
        }
    }
}
