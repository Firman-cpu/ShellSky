import QtQuick
import QtQuick.Controls
import Quickshell

PanelWindow {
    id: bar
    required property var shellScreen
    screen: shellScreen
    anchors { top: true; left: true; right: true }
    implicitHeight: 58
    exclusiveZone: 58
    color: "transparent"

    property bool launcherOpen: false
    property bool controlOpen: false
    property bool notificationsOpen: false

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        radius: 18
        color: "#0b2340d9"
        border.color: "#9acbff28"
        border.width: 1

        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "#ffffff05"
        }

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 128
            height: 36
            radius: 13
            color: brandMouse.containsMouse ? "#72b8ff16" : "transparent"

            Row {
                anchors.centerIn: parent
                spacing: 9
                Text { text: "☁"; color: "#9bd0ff"; font.pixelSize: 16 }
                Text { text: "ShellSky"; color: "#edf7ff"; font.pixelSize: 14; font.weight: Font.DemiBold }
            }

            MouseArea {
                id: brandMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    bar.launcherOpen = !bar.launcherOpen
                    bar.controlOpen = false
                    bar.notificationsOpen = false
                }
            }
        }

        WorkspaceBar {
            anchors.centerIn: parent
            height: 36
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            StatusCluster {}

            Rectangle {
                width: 36
                height: 36
                radius: 12
                color: notificationMouse.containsMouse ? "#72b8ff16" : "transparent"
                Text { anchors.centerIn: parent; text: "󰂚"; color: "#d9ebff"; font.pixelSize: 16 }
                MouseArea {
                    id: notificationMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        bar.notificationsOpen = !bar.notificationsOpen
                        bar.launcherOpen = false
                        bar.controlOpen = false
                    }
                }
            }

            Rectangle {
                width: 36
                height: 36
                radius: 12
                color: controlMouse.containsMouse ? "#72b8ff16" : "transparent"
                Text { anchors.centerIn: parent; text: "⚙"; color: "#d9ebff"; font.pixelSize: 16 }
                MouseArea {
                    id: controlMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        bar.controlOpen = !bar.controlOpen
                        bar.launcherOpen = false
                        bar.notificationsOpen = false
                    }
                }
            }

            Text {
                id: clock
                width: 92
                horizontalAlignment: Text.AlignRight
                anchors.verticalCenter: parent.verticalCenter
                color: "#edf7ff"
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
        anchor.rect.y: bar.height + 8
        width: Math.min(bar.width - 36, 720)
        height: Math.min(bar.screen.height - 110, 500)
        visible: bar.launcherOpen
        grabFocus: true
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 24
            color: "#0c2643f2"
            border.color: "#9acbff30"
            border.width: 1

            Column {
                anchors.fill: parent
                anchors.margins: 22
                spacing: 14

                Text { text: "Applications"; color: "#edf7ff"; font.pixelSize: 22; font.weight: Font.DemiBold }

                TextField {
                    id: search
                    width: parent.width
                    placeholderText: "Search applications..."
                    color: "#edf7ff"
                    placeholderTextColor: "#7e9bb8"
                    focus: true
                    background: Rectangle { radius: 14; color: "#72b8ff0b"; border.color: "#9acbff20" }
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
                        color: mouse.containsMouse ? "#72b8ff18" : "#ffffff06"

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
                            Text { text: modelData.name; color: "#edf7ff"; font.pixelSize: 13; font.weight: Font.DemiBold }
                            Text { text: modelData.genericName || modelData.comment || ""; color: "#829fbd"; font.pixelSize: 11; elide: Text.ElideRight; width: appList.width - 80 }
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
        anchor.rect.y: bar.height + 8
        width: 360
        height: 500
        visible: bar.controlOpen
        grabFocus: true
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 24
            color: "#0c2643f2"
            border.color: "#9acbff30"
            border.width: 1

            Column {
                anchors.fill: parent
                anchors.margins: 22
                spacing: 14

                Text { text: "Control Center"; color: "#edf7ff"; font.pixelSize: 22; font.weight: Font.DemiBold }
                Text { text: "System controls and quick settings"; color: "#829fbd"; font.pixelSize: 12 }
                StatusCluster { width: parent.width; height: 44 }

                Repeater {
                    model: ["Wi-Fi", "Bluetooth", "Night Light", "Do Not Disturb"]
                    delegate: Rectangle {
                        required property int index
                        width: parent.width
                        height: 58
                        radius: 14
                        color: toggleMouse.containsMouse ? "#72b8ff18" : "#ffffff06"
                        border.color: "#9acbff16"
                        Text { anchors.left: parent.left; anchors.leftMargin: 16; anchors.verticalCenter: parent.verticalCenter; text: modelData; color: "#d9ebff"; font.pixelSize: 13 }
                        Text { anchors.right: parent.right; anchors.rightMargin: 16; anchors.verticalCenter: parent.verticalCenter; text: "READY"; color: "#72b8ff"; font.pixelSize: 11; font.weight: Font.DemiBold }
                        MouseArea { id: toggleMouse; anchors.fill: parent; hoverEnabled: true }
                    }
                }
            }
        }
    }

    NotificationPanel {
        id: notificationPanel
        panelWindow: bar
        open: bar.notificationsOpen
    }
}
