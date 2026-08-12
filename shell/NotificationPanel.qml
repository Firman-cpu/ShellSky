import QtQuick
import QtQuick.Controls
import Quickshell

PopupWindow {
    id: root
    property bool open: false
    property var parentWindow

    anchor.window: parentWindow
    anchor.rect.x: parentWindow ? parentWindow.width - width - 18 : 0
    anchor.rect.y: parentWindow ? parentWindow.height + 10 : 0
    width: 390
    height: 540
    visible: open
    grabFocus: true
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 24
        color: "#121a27f5"
        border.color: "#ffffff1c"
        border.width: 1

        Column {
            anchors.fill: parent
            anchors.margins: 22
            spacing: 14

            Row {
                width: parent.width
                Text {
                    text: "Notifications"
                    color: "#f4f7ff"
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                }
                Item { width: parent.width - 150; height: 1 }
                Text {
                    text: String(NotificationService.trackedNotifications.values.length)
                    color: "#8ab4ff"
                    font.pixelSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListView {
                width: parent.width
                height: parent.height - 60
                clip: true
                spacing: 10
                model: NotificationService.trackedNotifications

                delegate: Rectangle {
                    required property var modelData
                    width: ListView.view.width
                    height: 94
                    radius: 16
                    color: "#ffffff08"
                    border.color: "#ffffff0d"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 14
                        spacing: 5

                        Row {
                            width: parent.width
                            spacing: 8
                            Text { text: modelData.appName; color: "#8ab4ff"; font.pixelSize: 11; font.weight: Font.DemiBold }
                            Item { width: parent.width - 100; height: 1 }
                            Text {
                                text: "×"
                                color: "#72809a"
                                font.pixelSize: 18
                                MouseArea { anchors.fill: parent; onClicked: modelData.dismiss() }
                            }
                        }
                        Text { text: modelData.summary; color: "#f4f7ff"; font.pixelSize: 13; font.weight: Font.DemiBold; elide: Text.ElideRight; width: parent.width }
                        Text { text: modelData.body; color: "#9da8bd"; font.pixelSize: 11; wrapMode: Text.WordWrap; maximumLineCount: 2; width: parent.width }
                    }
                }
            }
        }
    }
}