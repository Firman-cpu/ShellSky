import Quickshell
import QtQuick

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                anchors.fill: true
                color: "#080b12"
                aboveWindows: false

                Rectangle {
                    anchors.fill: parent
                    color: "#080b12"

                    Rectangle {
                        width: parent.width * 0.55
                        height: parent.height * 0.55
                        anchors.centerIn: parent
                        radius: width
                        color: "#233d66"
                        opacity: 0.20
                    }

                    Rectangle {
                        width: parent.width * 0.30
                        height: width
                        x: parent.width * 0.08
                        y: parent.height * 0.18
                        radius: width
                        color: "#526f9f"
                        opacity: 0.09
                    }

                    Text {
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: -10
                        text: "ShellSky"
                        color: "#f4f7ff"
                        font.pixelSize: 48
                        font.weight: Font.DemiBold
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.verticalCenter
                        anchors.topMargin: 38
                        text: "A new sky for your desktop"
                        color: "#9da8bd"
                        font.pixelSize: 13
                    }
                }
            }
        }
    }

    TopBar {}
    BottomDock {}
}
