import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    id: root
    property var parentWindow
    spacing: 4
    height: 30

    Repeater {
        model: SystemTray.items

        delegate: Rectangle {
            required property var modelData
            width: 30
            height: 30
            radius: 9
            color: trayMouse.containsMouse ? "#ffffff10" : "transparent"

            Image {
                anchors.centerIn: parent
                width: 18
                height: 18
                source: modelData.icon
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                id: trayMouse
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: function(mouse) {
                    if (mouse.button === Qt.RightButton && modelData.hasMenu && root.parentWindow)
                        modelData.display(root.parentWindow, mouse.x, mouse.y)
                    else
                        modelData.activate()
                }
            }
        }
    }
}