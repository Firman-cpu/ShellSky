import QtQuick
import QtQuick.Controls
import Quickshell

PanelWindow {
    id: bar
    required property var shellScreen
    screen: shellScreen
    anchors { top: true; left: true; right: true }
    implicitHeight: 44
    exclusiveZone: 44
    color: "transparent"

    property bool launcherOpen: false
    property bool controlOpen: false

    Rectangle {
        anchors.fill: parent
        color: "#111722e8"
        border.color: "#ffffff18"
        border.width: 1

        Rectangle {
            id: brandButton
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 118
            height: 32
            radius: 12
            color: brandMouse.containsMouse ? "#ffffff10" : "transparent"

            Text {
                anchors.centerIn: parent
                text: "☁  ShellSky"
                color: "#f4f7ff"
                font.pixelSize: 14
                font.weight: Font.DemiBold
            }

            MouseArea {
                id: brandMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.launcherOpen = !bar.launcherOpen
                    bar.controlOpen = false
                }
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Rectangle {
                width: 34
                height: 30
                radius: 10
                color: controlMouse.containsMouse ? "#ffffff10" : "transparent"
                Text { anchors.centerIn: parent; text: "⚙"; color: "#dce5f8"; font.pixelSize: 15 }
                MouseArea {
                    id: controlMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        bar.controlOpen = !bar.controlOpen
                        bar.launcherOpen = false
                    }
                }
            }

            Text {
                id: clock
                width: 82
                horizontalAlignment: Text.AlignRight
                anchors.verticalCenter: parent.verticalCenter
                color: "#f4f7ff"
                font.pixelSize: 13
                font.weight: Font.DemiBold
                text: Qt.formatDateTime(new Date(), "ddd  HH:mm")
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd  HH:mm")
        }
    }

    PopupWindow {
        id: launcher
        anchor.window: bar
        anchor.rect.x: Math.max(18, bar.width / 2 - width / 2)
        anchor.rect.y: bar.height + 10
        width: Math.min(bar.width - 36, 760)
        height: Math.min(bar.screen.height - 110, 520)
        visible: bar.launcherOpen
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

                Text {
                    text: "Applications"
                    color: "#f4f7ff"
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                }

                TextField {
                    id: search
                    width: parent.width
                    placeholderText: "Search applications..."
                    color: "#f4f7ff"
                    placeholderTextColor: "#72809a"
                    focus: true
                    background: Rectangle {
                        radius: 14
                        color: "#ffffff08"
                        border.color: "#ffffff12"
                    }
                    onTextChanged: appList.currentIndex = 0
                }

                ListView {
                    id: appList
                    width: parent.width
                    height: parent.height - 90
                    clip: true
                    spacing: 8
                    model: DesktopEntries.applications.values.filter(function(entry) {
                        return entry.name.toLowerCase().indexOf(search.text.toLowerCase()) !== -1
                    }).slice(0, 32)

                    delegate: Rectangle {
                        required property var modelData
                        width: appList.width
                        height: 58
                        radius: 14
                        color: mouse.containsMouse ? "#8ab4ff18" : "#ffffff07"

                        Image {
                            anchors.left: parent.left
                            anchors.leftMargin: 14
                            anchors.verticalCenter: parent.verticalCenter
                            width: 32
                            height: 32
                            source: modelData.icon ? Quickshell.iconPath(modelData.icon, true) : ""
                            fillMode: Image.PreserveAspectFit
                        }

                        Column {
                            anchors.left: parent.left
                            anchors.leftMargin: 58
                            anchors.verticalCenter: parent.verticalCenter
                            Text { text: modelData.name; color: "#f4f7ff"; font.pixelSize: 13; font.weight: Font.DemiBold }
                            Text { text: modelData.genericName || modelData.comment || ""; color: "#8290a8"; font.pixelSize: 11; elide: Text.ElideRight; width: appList.width - 80 }
                        }

                        MouseArea {
                            id: mouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                modelData.execute()
                                bar.launcherOpen = false
                            }
                        }
                    }
                }
            }
        }
    }

    PopupWindow {
        id: control
        anchor.window: bar
        anchor.rect.x: bar.width - width - 18
        anchor.rect.y: bar.height + 10
        width: 360
        height: 500
        visible: bar.controlOpen
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

                Text { text: "Control Center"; color: "#f4f7ff"; font.pixelSize: 22; font.weight: Font.DemiBold }
                Text { text: "Quick controls"; color: "#8290a8"; font.pixelSize: 12 }

                Repeater {
                    model: ["Wi-Fi", "Bluetooth", "Night Light", "Do Not Disturb"]
                    delegate: Rectangle {
                        required property int index
                        width: parent.width
                        height: 58
                        radius: 14
                        color: toggleMouse.containsMouse ? "#8ab4ff18" : "#ffffff07"
                        border.color: "#ffffff0d"

                        Text { anchors.left: parent.left; anchors.leftMargin: 16; anchors.verticalCenter: parent.verticalCenter; text: modelData; color: "#dce5f8"; font.pixelSize: 13 }
                        Text { anchors.right: parent.right; anchors.rightMargin: 16; anchors.verticalCenter: parent.verticalCenter; text: index < 2 ? "ON" : "OFF"; color: index < 2 ? "#8ab4ff" : "#72809a"; font.pixelSize: 11; font.weight: Font.DemiBold }

                        MouseArea { id: toggleMouse; anchors.fill: parent; hoverEnabled: true }
                    }
                }
            }
        }
    }
}