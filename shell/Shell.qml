import QtQuick

Item {
    id: shell
    anchors.fill: parent

    property color panelColor: "#102b4dcc"
    property color panelBorder: "#9acbff28"
    property color textPrimary: "#eef7ff"
    property color textSecondary: "#a9c3df"
    property color accent: "#72b8ff"

    Image {
        anchors.fill: parent
        source: "../assets/wallpaper.svg"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#071322"
        opacity: 0.10
    }

    // ShellSky branding is intentionally part of the wallpaper, not a permanent UI element.
}
